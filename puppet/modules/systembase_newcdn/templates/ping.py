#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# depends:
#  pip install pyip gevent greenlet
#

import gevent
import gevent.monkey

gevent.monkey.patch_all()

from gevent.threadpool import ThreadPool
from gevent.pool import Pool, Group
from optparse import OptionParser
from urllib2 import urlopen, HTTPError, Request
from uuid import uuid4

import socket
import os
import ip
import icmp
import udp
import time
import json
import logging
import urlparse
import urllib
import httplib
import string


euid = os.geteuid()
MAX_RTT = 99                    # 99s
options = None
loss_config = {}
speed_calculator = None
delay_calculator = None


def load_lossconf():
    try:
        global loss_config
        t = json.load(open(options.lossconf))
        t.update(loss_config)
        loss_config = t
    except Exception as e:
        logging.debug('load loss config failed: %s', e)


def save_lossconf():
    try:
        lossconf = options.lossconf
        lossconf_swp = '%s.swp.%d' % (lossconf, os.getpid())

        # update loss config
        load_lossconf()
        json.dump(loss_config, open(lossconf_swp, 'w'))
        os.rename(lossconf_swp, lossconf)
    except Exception as e:
        logging.debug('save loss config failed: %s', e)


def evaluate_delay(m):
    delay = 0
    v = loss_config.get(m)
    if v and callable(delay_calculator):
        delay = v[1] + delay_calculator(v[0]) - time.time()

    return delay


def evaluate_speed_factor(m):
    factor = 1
    if callable(speed_calculator):
        factor = speed_calculator(m)
        if factor <= 0:
            factor = 1

    return factor


def check_expression(e):
    symbols = set(['x', '+', '-', '*', '/', '(', ')', '.', '&', '|', '^'])
    digits = set(string.digits)
    for i in e:
        if i not in symbols and i not in digits:
            return False

    return True


def set_delay_calculator(e):
    if isinstance(e, str) and check_expression(e):
        global delay_calculator
        delay_calculator = lambda x: eval(str(e).replace('x', str(x)))


def set_speed_calculator(e):
    if isinstance(e, str) and check_expression(e):
        global speed_calculator
        speed_calculator = lambda x: eval(str(e).replace('x', str(x)))


def update_url_query(url, **kwargs):
    result = list(urlparse.urlparse(url))
    query = dict(urlparse.parse_qsl(result[4]))
    query.update(kwargs)
    result[4] = urllib.urlencode(query)
    return urlparse.urlunparse(result)


def file_split(f, delim='\n', bufsize=1024):
    prev = ''
    while True:
        s = f.read(bufsize)
        if not s:
            break
        split = s.split(delim)
        if len(split) > 1:
            yield prev + split[0]
            prev = split[-1]
            for x in split[1:-1]:
                yield x
        else:
            prev += s
    if prev:
        yield prev


def get_hostid(hostsconf):
    cdnid, diskid = '', ''
    for item in file_split(open(hostsconf), delim=';'):
        try:
            name, value = item.split(' ', 1)
            name = name.strip()
            if name == 'host_cdnid':
                cdnid = value.strip()
            elif name == 'host_diskid':
                diskid = value.strip()
        except Exception as e:
            logging.debug(e, exc_info=True)

    return cdnid, diskid


class Pinger(object):
    def __init__(self, bindaddr, peeraddr):
        self._peer = peeraddr
        self._connected = False
        self._sock = self.open_socket(bindaddr, peeraddr)
        self._type = self._sock.type

    def send(self, pkt_id, seq, data):
        buf = self.make_sending_data(pkt_id, seq, data)
        if self._connected:
            plen = self._sock.send(buf)
        else:
            plen = self._sock.sendto(buf, 0, self._peer)
        return plen

    def recv(self, pkt_id, seq, buflen=None):
        cond = lambda: True

        timeout = self._sock.gettimeout()
        if timeout:
            startup = time.time()
            cond = lambda: time.time() - startup < timeout

        while cond():
            try:
                buf = self._sock.recv(buflen or 65535)
                return self.extract_received_data(pkt_id, seq, buf)
            except (AssertionError, ValueError) as e:
                logging.debug(e, exc_info=True)

    def ping(self, pkt_id, seq, size, timeout):
        self._sock.settimeout(timeout)
        begtime = '%.6f' % time.time()
        headlen = len(begtime)
        restlen = max(size - headlen, 0)
        self.send(pkt_id, seq, begtime + '\0' * restlen)
        data, endtime = self.recv(pkt_id, seq), time.time()
        assert len(data) == headlen + restlen
        assert begtime == data[:headlen]
        rtt = endtime - float(begtime)
        return headlen + restlen, float('%.6f' % rtt)

    def open_socket(self, bindaddr=None, peeraddr=None):
        sock_type = socket.SOCK_RAW
        sock_proto = socket.IPPROTO_ICMP

        myeuid = os.geteuid()
        if myeuid or myeuid != euid:
            try:
                os.seteuid(euid)
                if euid and os.uname()[0] == 'Darwin':
                    sock_type = socket.SOCK_DGRAM
            except os.error:
                pass

        sock = socket.socket(socket.AF_INET,
                             sock_type,
                             sock_proto)
        os.setuid(os.getuid())      # drop privilege if any

        try:
            if bindaddr:
                if sock_type == socket.SOCK_DGRAM:
                    if hasattr(socket, 'SO_REUSEPORT'):
                        sock.setsockopt(socket.SOL_SOCKET,
                                        socket.SO_REUSEPORT,
                                        True)
                    sock.bind(bindaddr)
                elif sock_type == socket.SOCK_RAW:
                    # TODO: SO_BINDTODEVICE
                    pass
            if peeraddr:
                sock.connect(peeraddr)
                self._connected = True
        except Exception as e:
            logging.debug(e, exc_info=True)

        return sock

    def make_sending_data(self, pkt_id, seq, data):
        if self._type == socket.SOCK_DGRAM:
            udp_pkt = udp.Packet(sport=self._peer[1], data=data)
            data = udp.assemble(udp_pkt)

        if self._type in (socket.SOCK_RAW, socket.SOCK_DGRAM):
            icmp_pkt = icmp.Echo(id=pkt_id, seq=seq, data=data)
            return icmp.assemble(icmp_pkt)

        raise NotImplementedError(self._type)

    def extract_received_data(self, pkt_id, seq, data):
        if self._type in (socket.SOCK_RAW, socket.SOCK_DGRAM):
            ip_pkt = ip.disassemble(data)
            logging.debug(ip_pkt)
            icmp_pkt = icmp.disassemble(ip_pkt.data)
            logging.debug(icmp_pkt)
            assert icmp_pkt.get_type() == self.reply_type()
            assert icmp_pkt.get_id() == pkt_id

            if hasattr(self, 'pong_pool'):
                self.pong_pool[icmp_pkt.get_seq()] = icmp_pkt.get_data()
                logging.debug('pong pool size: %d', len(self.pong_pool))

            logging.debug('expect %d, actually %d', seq, icmp_pkt.get_seq())

            if hasattr(self, 'pong_pool') and seq in self.pong_pool:
                data = self.pong_pool[seq]
            else:
                assert icmp_pkt.get_seq() == seq
                data = icmp_pkt.get_data()
        else:
            raise NotImplementedError(self._type)

        if self._type == socket.SOCK_DGRAM:
            udp_pkt = udp.disassemble(data)
            logging.debug(udp_pkt)
            assert udp_pkt.sport == self._peer[1]
            data = udp_pkt.data

        return data

    def reply_type(self):
        return icmp.ICMP_ECHOREPLY


class PingHandler(object):
    def __init__(self, targets, concurrency=1000, pool=None, pinger=None, frequence=''):
        hosts, hostinfos = [], {}
        for k in targets:
            hostinfo = ip = k
            if isinstance(k, dict):
                cdnid, diskid, ip = str(k['cdnid']), str(k['diskid']), str(k['ip'])
                hostinfo = '-'.join([cdnid, diskid, ip])
            else:
                assert isinstance(k, str)

            hosts.append(ip)
            hostinfos[ip.split(':')[0]] = hostinfo

        self._hosts = hosts
        self._hostinfos = hostinfos
        self._port = 20000
        self._seq = 0
        self._id = os.getpid() & 0xffff
        self._pool = pool and pool(concurrency) or Pool(concurrency)
        self._spawns = 0
        self._freq_times = 0
        self._freq_secs = 0
        if frequence:
            freq = frequence.split(':')
            if len(freq) == 2:
                self._freq_times, self._freq_secs = int(freq[0]), int(freq[1])

        pinger = pinger or Pinger
        pinger.pong_pool = {}
        self._pinger = pinger

    def _spawn(self, func, *args, **kwargs):
        self._pool.spawn(func, *args, **kwargs)
        self._spawns += 1
        if self._freq_times > 0 and self._spawns % self._freq_times == 0:
            logging.debug('spawns %d-th routine, sleep %ds', self._spawns, self._freq_secs)
            time.sleep(self._freq_secs)

    def get_port(self):
        port = self._port
        self._port += 1
        if self._port > 65535:
            self._port = 20000
        return port

    def get_seq(self):
        seq = self._seq
        self._seq += 1
        if self._seq > 65535:
            self._seq = 0
        return seq

    def handle_icmp(self, host, interval, count, size, timeout):
        ip = socket.gethostbyname(host.split(':')[0])
        rtts = [None] * count
        num_lost = [0]
        uuid = uuid4()

        def handle(index, size):
            lost, startup, rtt = 0, time.time(), MAX_RTT

            try:
                pkt_id, seq, port = self._id, self.get_seq(), self.get_port()
                pinger = self._pinger(('0.0.0.0', port), (ip, port))
                size, rtt = pinger.ping(pkt_id, seq, size, timeout)
            except Exception as e:
                logging.debug(e, exc_info=True)
                lost = 1
                num_lost[0] += 1
                rtt = time.time() - startup
            finally:
                rtts[index] = rtt
                self.once_icmp_replied(host, rtt, lost, seq, ip, size, uuid)
                gevent.sleep(interval)

        group = Group()
        for i in xrange(count):
            if interval == 0:
                group.add(gevent.spawn(handle, i, size))
            else:
                handle(i, size)

        if interval == 0:
            group.join()

        if count > 0:
            if num_lost[0] == count:
                avg_rtt = min_rtt = max_rtt = MAX_RTT
            else:
                avg_rtt = 0
                min_rtt, max_rtt = 2**32 - 1, -1
                for rtt in rtts:
                    if rtt is None:
                        continue

                    avg_rtt += rtt / count
                    if rtt < min_rtt:
                        min_rtt = rtt
                    if rtt > max_rtt:
                        max_rtt = rtt

                avg_rtt = float('%.6f' % avg_rtt)
                min_rtt = float('%.6f' % min_rtt)
                max_rtt = float('%.6f' % max_rtt)

            self.once_icmp_finished(host, count, count - num_lost[0],
                                    min_rtt, avg_rtt, max_rtt, uuid)

    def ping(self, interval=1, count=5, size=64, timeout=10):
        for host in self._hosts:
            self._pool.spawn(self.handle_icmp,
                             host, interval, count, size, timeout)

    def once_icmp_replied(self, host, rtt, lost, seq, ip, size, uuid):
        pass

    def once_icmp_finished(self, host, total, ok,
                           min_rtt, avg_rtt, max_rtt, uuid):
        pass


class MorePingHandler(PingHandler):
    def __init__(self, uris, *args, **kwargs):
        PingHandler.__init__(self, *args, **kwargs)
        self._uris = uris
        self._expect_messages = 0   # number of result messages will produce

    def ping_before(self):
        pass

    def ping_after(self):
        pass

    def ping(self,
             icmp_interval=1, icmp_count=5, icmp_size=64, icmp_timeout=10,
             http_interval=0, http_count=1, http_timeout=20,
             http_add_ports='', http_add_ports_only=False):
        self.ping_before()
        for host in self._hosts:
            if icmp_count > 0:
                self._expect_messages += icmp_count + 1   # add an extra finished message
                self._spawn(self.handle_icmp,
                            host,
                            icmp_interval,
                            icmp_count,
                            icmp_size,
                            icmp_timeout)
            for uri in self._uris:
                if http_count > 0:
                    hosts = [(host, 'http')] if not http_add_ports_only else []
                    h_p = host.split(':')
                    h, p = h_p[0], 80
                    if len(h_p) > 1:
                        p = h_p[1]

                    for t in http_add_ports.split(','):
                        if not t:
                            continue
                        try:
                            tag = 'http:' + t
                            if t[0] == '+':
                                t = int(p) + int(t[1:])

                            t = int(t)
                            if 0 < t <= 65535:
                                m = '%s:%d' % (h, t)
                                if evaluate_delay(m) <= 0:
                                    hosts.append((m, tag))
                        except:
                            continue

                    for h, tag in hosts:
                        self._expect_messages += http_count + 1   # add an extra finished message
                        self._spawn(self.handle_http,
                                    h,
                                    uri,
                                    http_interval,
                                    http_count,
                                    http_timeout,
                                    tag=tag)
        self.ping_after()

    def handle_http(self, host, uri, interval, count, timeout, **kwargs):
        tag = kwargs.get('tag', 'http')
        num_ok = [0]
        speeds = [None] * count
        url = 'http://{host}{uri}'.format(host=host, uri=uri)
        uuid = uuid4()

        def handle(index):
            try:
                size = 0
                seq, startup = self.get_seq(), time.time()
                res = urlopen(url, timeout=timeout)
                while time.time() - startup < timeout:
                    chunk = res.read(8192)
                    if not chunk:
                        break
                    size += len(chunk)
                errcode = res.getcode()
                num_ok[0] += 1
            except HTTPError as e:
                logging.debug(e, exc_info=True)
                errcode = e.getcode()
            except Exception as e:
                logging.debug('%s: %s' % (url, e), exc_info=True)
                errcode = -1
            finally:
                rtt = time.time() - startup or 1e-6
                speed = int(size / rtt)

                try:
                    loss = 0
                    h_p = host.split(':')
                    ip = h_p[0]
                    port = 80 if len(h_p) == 1 else int(h_p[1])
                    if port > 50000:
                        loss = int(os.popen('/cto2/ctocmd -l ' + ip).read())
                        speed *= evaluate_speed_factor(loss)

                    loss_config[host] = [loss, time.time()]
                except ValueError:
                    pass
                except Exception as e:
                    logging.debug(e)

                speeds[index] = speed
                self.once_http_responsed(
                    tag, host, speed, errcode, seq, uri, size, uuid)
                gevent.sleep(interval)

        group = Group()
        for i in xrange(count):
            if interval == 0:
                group.add(gevent.spawn(handle, i))
            else:
                handle(i)

        if interval == 0:
            group.join()

        if count > 0:
            if num_ok[0] == 0:
                avg_speed = min_speed = max_speed = 0
            else:
                avg_speed, min_speed, max_speed = 0, 2**32 - 1, -1
                for speed in speeds:
                    if speed is None:
                        continue

                    avg_speed += speed / count
                    if speed < min_speed:
                        min_speed = speed
                    if speed > max_speed:
                        max_speed = speed

                avg_speed = float('%.6f' % avg_speed)
                min_speed = float('%.6f' % min_speed)
                max_speed = float('%.6f' % max_speed)

            self.once_http_finished(tag, host, count, num_ok[0],
                                    min_speed, avg_speed, max_speed, uuid)

    def once_http_responsed(self, tag, host, speed, code, seq, uri, size, uuid):
        pass

    def once_http_finished(self, tag, host, total, ok,
                           min_speed, avg_speed, max_speed, uuid):
        pass


class ConsolePinger(MorePingHandler):
    def __init__(self, *args, **kwargs):
        MorePingHandler.__init__(self, *args, **kwargs)

    def once_icmp_replied(self, host, rtt, lost, seq, ip, size, uuid):
        if lost == 1:
            return

        p = '{size} bytes from {host} ({ip}): icmp_seq={seq} time={rtt}ms'
        logging.info(p.format(size=size,
                              host=host,
                              ip=ip,
                              seq=seq,
                              rtt='%.3f' % (rtt * 1000)))

    def once_icmp_finished(self, host, total, ok,
                           min_rtt, avg_rtt, max_rtt, uuid):
        if ok == 0:
            loss = 100
        else:
            loss = (1 - float('%.4f' % (ok * 1.0 / total))) * 100

        p = '''
--- {host} ping statistics ---
{total} packets transmitted, {ok} packets received, {loss}% packet loss.'''
        logging.info(p.format(host=host, total=total, ok=ok, loss=loss))
        if loss < 100:
            logging.info('round-trip (ms)   min/avg/max = {min}/{avg}/{max}'.
                         format(min='%.3f' % (min_rtt * 1000),
                                avg='%.3f' % (avg_rtt * 1000),
                                max='%.3f' % (max_rtt * 1000)))

    def once_http_responsed(self, tag, host, speed, code, seq, uri, size, uuid):
        if code != 200:
            return

        p = '{size} bytes from {host} ({uri}): http_seq={seq} speed={speed}kB/s'
        logging.info(p.format(size=size, host=host, uri=uri,
                              seq=seq,
                              speed='%.3f' % (speed / 1024.0)))

    def once_http_finished(self, tag, host, total, ok,
                           min_speed, avg_speed, max_speed, uuid):
        if ok == 0:
            failed = 100
        else:
            failed = (1 - float('%.4f' % (ok * 1.0 / total))) * 100

        p = '''
--- {host} http statistics ---
{total} requests transmitted, {ok} requests succeeded, {failed}% requests failed.'''
        logging.info(p.format(
            host=host, total=total, ok=ok, failed=failed))
        if failed < 100:
            logging.info('speed (kB/s)   min/avg/max = {min}/{avg}/{max}'.
                         format(min='%.3f' % (min_speed / 1024.0),
                                avg='%.3f' % (avg_speed / 1024.0),
                                max='%.3f' % (max_speed / 1024.0)))


class ReportPinger(MorePingHandler):
    def __init__(self, source, uploads, timeout, *args, **kwargs):
        MorePingHandler.__init__(self, *args, **kwargs)

        def dns_parse(i):
            url = uploads[i]
            r = list(urlparse.urlparse(url))
            if r and r[0] != 'http' and r[1]:
                host_port = r[1].split(':', 1)
                rest = ''.join(host_port[1:])
                r[1] = socket.gethostbyname(host_port[0]) + (
                    rest if not rest
                    else (':' + rest))

                uploads[i] = urlparse.urlunparse(r)

        group = Group()
        for i in xrange(len(uploads)):
            group.add(gevent.spawn(dns_parse, i))
        group.join()

        self._uploads = uploads
        self._timeout = timeout

        if isinstance(source, dict):
            self._source = '-'.join([str(source['cdnid']),
                                     str(source['diskid']),
                                     str(source['ip'])])
        else:
            assert isinstance(source, str)
            self._source = source

    def once_icmp_replied(self, host, rtt, lost, seq, ip, size, uuid):
        # ms
        rtt = '%.3f' % (rtt * 1000)
        self.report(','.join([
            str('icmp'),
            str(self._source),
            str(self._hostinfos[host.split(':')[0]]),
            str(rtt),
            str(lost),
            str(seq),
            str(ip),
            str(size),
            str(int(time.time())),
            str(uuid),
        ]))

    def once_icmp_finished(self, host, total, ok,
                           min_rtt, avg_rtt, max_rtt, uuid):
        self.report(','.join([
            str('icmp-stat'),
            str(self._source),
            str(self._hostinfos[host.split(':')[0]]),
            str(total),
            str(ok),
            str('%.3f' % (min_rtt * 1000)),
            str('%.3f' % (avg_rtt * 1000)),
            str('%.3f' % (max_rtt * 1000)),
            str(int(time.time())),
            str(uuid),
        ]))

    def once_http_responsed(self, tag, host, speed, code, seq, uri, size, uuid):
        # kB/s
        speed = '%.3f' % (speed / 1024.0)
        self.report(','.join([
            str(tag),
            str(self._source),
            str(self._hostinfos[host.split(':')[0]]),
            str(speed),
            str(code),
            str(seq),
            str(uri),
            str(size),
            str(int(time.time())),
            str(uuid),
        ]))

    def once_http_finished(self, tag, host, total, ok,
                           min_speed, avg_speed, max_speed, uuid):
        self.report(','.join([
            str(tag + '-stat'),
            str(self._source),
            str(self._hostinfos[host.split(':')[0]]),
            str(total),
            str(ok),
            str('%.3f' % (min_speed / 1024.0)),
            str('%.3f' % (avg_speed / 1024.0)),
            str('%.3f' % (max_speed / 1024.0)),
            str(int(time.time())),
            str(uuid),
        ]))

    def report(self, data):
        for target in self._uploads:
            self._pool.spawn(self.perform_report, target, data)

    def get_sender_and_halter(self, target):
        r = urlparse.urlparse(target)
        logging.debug(r)

        sender, halter = None, None

        if r.scheme in ('udp', 'tcp'):
            host_serv = r.netloc.split(':')
            host = host_serv[0]
            serv = int(80 if len(host_serv) == 1 else host_serv[1])
            if r.scheme == 'udp':
                sender, halter = self.perform_report_udp(host, serv)
            elif r.scheme == 'tcp':
                sender, halter = self.perform_report_tcp(host, serv)
        elif r.scheme == 'unix':
            sender, halter = self.perform_report_unix(r.path)
        elif r.scheme == 'http':
            sender, halter = self.perform_report_post(target)
        else:
            raise NotImplementedError(target)

        return sender, halter

    def apply_send(self, sender, *args):
        for data in args:
            logging.debug(data)
            sender(data)

    def perform_report(self, target, *args):
        try:
            sender, halter = self.get_sender_and_halter(target)
            assert callable(sender)

            self.apply_send(sender, *args)

            if callable(halter):
                halter()
        except Exception as e:
            logging.error('error(%s) for target: %s',
                          str(e), target, exc_info=True)

    def perform_report_tcp(self, host, port):
        sock = socket.create_connection((host, port), timeout=self._timeout)
        if hasattr(socket, 'TCP_CORK'):
            sock.setsockopt(socket.SOL_TCP, socket.TCP_CORK, 1)
        return sock.sendall, sock.close

    def perform_report_udp(self, host, port):
        sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        sock.connect((host, port))
        return sock.sendall, sock.close

    def perform_report_unix(self, path):
        sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        sock.connect(path)
        return sock.sendall, sock.close

    def perform_report_post(self, url):
        def send(data):
            req = Request(url, data=data, headers={
                'Content-Type': 'application/octet-stream',
            })
            resp = urlopen(req)
            logging.debug(resp.read())
            resp.close()

        return send, None


class KeepaliveReportPinger(ReportPinger):
    def __init__(self, *args, **kwargs):
        ReportPinger.__init__(self, *args, **kwargs)

    def ping_before(self):
        import gevent.queue
        self._queue = gevent.queue.Queue()

    def ping_after(self):
        for target in self._uploads:
            self._pool.spawn(self.perform_report, target)

    def report(self, data):
        self._queue.put(data)

    def apply_send(self, sender, *args):
        for _ in xrange(self._expect_messages):
            data = self._queue.get()
            logging.debug(data)
            sender(data)
            sender('\n')
        sender('\n')    # end

    def perform_report_udp(self, *args):
        raise NotImplementedError("UDP keepalive")

    def perform_report_post(self, url):
        r = urlparse.urlparse(url) if type(url) is str else url
        conn = httplib.HTTPConnection(r.netloc, timeout=self._timeout)
        conn.connect()
        uri = '/' if r.path == '' else (r.path + '?' + r.query)
        conn.putrequest('POST', uri)
        conn.putheader('Content-Type', 'application/octet-stream')
        conn.putheader('Transfer-Encoding', 'chunked')
        conn.endheaders()

        def send(data):
            conn.send(hex(len(data))[2:])
            conn.send('\r\n')
            conn.send(data)
            conn.send('\r\n')

        def halt():
            conn.send('0\r\n\r\n')
            resp = conn.getresponse()
            logging.debug(resp.read())
            resp.close()

            if resp.status != 200:
                raise Exception('HTTP Error: %d %s' % (resp.status, resp.reason))

        return send, halt


def check_pingconf(pingconf, expire):
    try:
        st = os.stat(pingconf)
        old = json.load(open(pingconf))
        return old, st.st_mtime + expire < time.time()
    except OSError:
        pass

    return None, True


def update_configs(domain, hostsconf, pingconf, expire):
    ''' file format like below:
    {
        "config": {
            'delay_revision': '',
            'speed_revision': '',
        },
        "source": {"cdnid": xxx, "diskid": xxx, "ip": xxx},
        "targets": [
            {"cdnid": xxx, "diskid": xxx, "ip": xxx},
            ...
        ],
        "includes": [
            {"cdnid": xxx, "diskid": xxx, "ip": xxx},
            ...
        ],
        "excludes": [
            {"cdnid": xxx, "diskid": xxx, "ip": xxx},
            ...
        ],
    }'''
    r, need_update = check_pingconf(pingconf, expire)
    if need_update:
        try:
            cdnid, diskid = get_hostid(hostsconf)
        except IOError:
            e = '''Could not load hostid from `%s`.
Please run with specific hosts, such as below:
    ping.py www.letv.com www.lecloud.com

Or re-run with a correct --hostsconf=PATH, whose content should be contains at least 2 elements:
    host_cdnid        XXX;
    host_diskid       XXX;''' % hostsconf
            raise Exception(e)

        url = update_url_query(domain, cdnid=cdnid, diskid=diskid)

        try:
            req = Request(url)
            req.add_header('Accept-Encoding', 'gzip')
            res = urlopen(req)

            f = res
            if res.info().get('Content-Encoding') == 'gzip':
                from StringIO import StringIO
                import gzip

                buf = StringIO(res.read())
                f = gzip.GzipFile(fileobj=buf)

            r = json.load(f)
        except (HTTPError, ValueError) as e:
            if not r:  # request failed and no historical record found
                raise Exception('''%s on request `%s`.
Please check the FBS domain `%s` or hostsconf `%s`.''' % (
                    e, url, domain, hostsconf))
            else:
                logging.warn('%s: retrieve config from `%s` failed, '
                             'prefer the recently used records.',
                             e, url)
        else:
            try:
                swpfile = pingconf + '.swp'
                json.dump(r, open(swpfile, 'w'))
                os.rename(swpfile, pingconf)
            except OSError as e:
                logging.error('Writing config failed: %s', e)

    source, targets = r['source'], []
    includes, excludes = r.get('includes') or [], r.get('excludes') or []

    includes.extend(r['targets'])
    items = ['cdnid', 'diskid', 'ip']

    def values(v, args):
        t = []
        for k in args:
            t.append(v.get(k, ''))

        t.extend([''] * (len(items) - len(t)))
        return t

    source_key = hash(tuple(values(source, items)))
    includes_set = set()
    excludes_set = set([hash(tuple(values(k, items))) for k in excludes])

    for k in includes:
        inc = True
        for i in xrange(len(items)):
            v = values(k, items[:i + 1])
            key = hash(tuple(v))
            if key in excludes_set or key == source_key:
                inc = False
                continue

        if inc:
            key = hash(tuple(values(k, items)))
            if key not in includes_set:
                targets.append(k)
                includes_set.add(key)

    return r.get('config', {}), source, targets


def main():
    parser = OptionParser(usage="usage: %prog [options] host...",
                          version="%prog 0.1.0")
    parser.add_option("-d", "--destination",
                      action="append",
                      metavar="URL",
                      dest="dest",
                      help="destination URLs to report")
    parser.add_option("-t", "--ping-timeout",
                      dest="ping_timeout",
                      default=10,
                      type=float,
                      help="time in second to ping each host")
    parser.add_option("-T", "--download-timeout",
                      dest="download_timeout",
                      default=20,
                      type=float,
                      help="time in second to download each file")
    parser.add_option("-w", "--wait-timeout",
                      dest="wait_timeout",
                      default=10,
                      type=float,
                      help="time in minute to wait all requests finish")
    parser.add_option("-u", "--upload-timeout",
                      dest="upload_timeout",
                      default=60,
                      type=float,
                      help="time in second to upload each testing result")
    parser.add_option("-i", "--ping-interval",
                      type=float,
                      default=0,
                      help="interval of ping for each host")
    parser.add_option("-I", "--download-interval",
                      type=float,
                      default=0,
                      help="interval of download for each file")
    parser.add_option("-s", "--ping-size",
                      type=int,
                      default=64,
                      help="size of message to ping for each host")
    parser.add_option("-n", "--ping-count",
                      type=int,
                      default=5,
                      help="ping count for each host")
    parser.add_option("-N", "--download-count",
                      type=int,
                      default=1,
                      help="download count for each host")
    parser.add_option("-f", "--file",
                      action="append",
                      metavar="URI",
                      help="file URI to test download speed")
    parser.add_option("-C", "--concurrency",
                      type=int,
                      default=1000,
                      help="concurrency limit")
    parser.add_option("--ready",
                      type=int,
                      default=300,
                      help="hanging up at `ready`-based second to ready run")
    parser.add_option("--debug",
                      action="store_true",
                      default=False,
                      help="enable debug logging")
    parser.add_option("--thread",
                      action="store_true",
                      default=False,
                      help="enable thread-pooled ping")
    parser.add_option("--processes",
                      type=int,
                      default=1,
                      help="specify the maximum number of running processes")
    parser.add_option("--frequence",
                      type=str,
                      default='',
                      help="the testing frequence setup as form of <times>:<seconds>")
    parser.add_option("--add-ports",
                      type=str,
                      default="",
                      help="additional http ports(separated by comma) to test")
    parser.add_option("--add-ports-only",
                      action="store_true",
                      default=False,
                      help="test additional http ports(separated by comma) only, i.e. ignores the original ports")
    parser.add_option("--keepalive",
                      action="store_true",
                      default=False,
                      help="using long connection on upload, doesn't support UDP")
    parser.add_option("--fbs-domain",
                      type=str,
                      default='http://greenping.cdn.lecloud.com/fbs/hosts',
                      help="domain to fetch target hosts")
    parser.add_option("--hostsconf",
                      type=str,
                      default='/usr/local/etc/hosts.conf',
                      help="configure file to load cdnid and diskid")
    parser.add_option("--pingconf",
                      type=str,
                      default='/var/tmp/ping.conf',
                      help="file to save config that fetched from FBS")
    parser.add_option("--conf-expire",
                      type=int,
                      default=300,
                      help="time in second to cache the config")
    parser.add_option("--lossconf",
                      type=str,
                      default='/var/tmp/ping_loss.conf',
                      help="the loss config produced by ping")
    parser.add_option("--delay-revision",
                      type=str,
                      default='x/5',
                      help='expression to calculate the testing delay')
    parser.add_option("--speed-revision",
                      type=str,
                      default='1.0/((x+10)/10)',
                      help='expression to calculate the speed factor')

    global options
    options, args = parser.parse_args()

    if options.debug:
        logging.basicConfig(
            level=logging.DEBUG,
            format='[%(levelname)1.1s %(asctime)s %(process)d:%(module)s:%(lineno)d ] %(message)s')
    else:
        logging.basicConfig(level=logging.INFO, format='%(message)s')

    config = {}
    source = ''
    targets = args or []

    if not targets:
        config, source, targets = update_configs(options.fbs_domain,
                                                 options.hostsconf,
                                                 options.pingconf,
                                                 options.conf_expire)
        ready = config.get('ready', options.ready)
        if ready > 0:
            second = hash(tuple(source.values())) % ready
            logging.debug("working at %d second later", second)
            time.sleep(second)

    uploads = config.get('dest', options.dest) or []
    upload_timeout = config.get('upload_timeout', options.upload_timeout)
    uris = config.get('file', options.file) or []
    concurrency = config.get('concurrency', options.concurrency)
    enable_thread = config.get('thread', options.thread)
    frequence = config.get('frequence', options.frequence)
    ping_interval = config.get('ping_interval', options.ping_interval)
    ping_timeout = config.get('ping_timeout', options.ping_timeout)
    ping_size = config.get('ping_size', options.ping_size)
    ping_count = config.get('ping_count', options.ping_count)
    download_interval = config.get('download_interval', options.download_interval)
    download_timeout = config.get('download_timeout', options.download_timeout)
    download_count = config.get('download_count', options.download_count)
    add_ports = config.get('add_ports', options.add_ports)
    add_ports_only = config.get('add_ports_only', options.add_ports_only)
    wait_timeout = config.get('wait_timeout', options.wait_timeout)
    processes = config.get('processes', options.processes)
    set_delay_calculator(config.get('delay_revision', options.delay_revision))
    set_speed_calculator(config.get('speed_revision', options.speed_revision))


    def process(targets):
        logging.debug('process len(targets): %d', len(targets))
        if not targets:
            return

        load_lossconf()

        pinger = None

        if uploads:
            Reporter = ReportPinger
            if options.keepalive:
                Reporter = KeepaliveReportPinger

            pinger = Reporter(source, uploads, upload_timeout, uris, targets,
                              concurrency=concurrency,
                              pool=enable_thread and ThreadPool,
                              frequence=frequence)
        else:
            pinger = ConsolePinger(uris, targets,
                                   concurrency=concurrency,
                                   pool=enable_thread and ThreadPool,
                                   frequence=frequence)

        pinger.ping(icmp_interval=ping_interval,
                    icmp_timeout=ping_timeout,
                    icmp_size=ping_size,
                    icmp_count=ping_count,
                    http_interval=download_interval,
                    http_timeout=download_timeout,
                    http_count=download_count,
                    http_add_ports=add_ports,
                    http_add_ports_only=add_ports_only)

        gevent.wait(timeout=wait_timeout * 60)

        save_lossconf()

    if processes > 1:
        pids = []
        step = (len(targets) - 1) / processes + 1
        last = 0
        for i in xrange(processes):
            first = last
            last += step

            t = targets[first:last]
            if not t:
                continue

            pid = os.fork()
            if pid == 0:    # child
                process(t)
                return
            elif pid > 0:
                pids.append(pid)

        if last < len(targets):
            pid = os.fork()
            if pid == 0:
                process(targets[last:])
                return
            else:
                pids.append(pid)

        for pid in pids:
            os.waitpid(pid, 0)
    else:
        process(targets)


if __name__ == '__main__':
    try:
        main()
    except Exception as e:
        logging.error(e, exc_info=options.debug if options else False)
