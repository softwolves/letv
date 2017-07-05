local report_host    = "log.cdn.letvcloud.com"
local r2h_report_uri = "/live/serverreport/flv"
local hls_report_uri = "/live/serverreport/hls"
local upstream = require "ngx.upstream"

local status_report_delay = 10  -- in seconds
local r2h_report_delay = 60
local upstream_delay = 60

local new_timer = ngx.timer.at
local log = ngx.log
local ERR = ngx.ERR
local token_check_delay = 3 * 60

local http = require("resty.http")

local function get_lock(delay, dict)

    local ok, err = dict:add("report_lock", true, delay - 0.001)

    if not ok then
        if err == "exists" then
            return nil
        end
        log(ERR, "failed to add report_lock: ", err) return nil
    end
    return true
end

status_report_func = function(premature)
    local status_report = ngx.shared.status_report

    if not premature then
        local ok, err = new_timer(status_report_delay, status_report_func)

        if not ok then
            log(ERR, "failed to create timer: ", err)
            return
        end

        if not get_lock(status_report_delay, status_report) then
            return
        end

        local sock = ngx.socket.tcp()
        local ok, err = sock:connect("127.0.0.1", 18980)
        sock:close()
        if not ok then
            ngx.log(ngx.ERR, "ATS is dead")
            return
        end

        local sock = ngx.socket.tcp()
        local ok, err = sock:connect("127.0.0.1", 80)

        if not ok then
            log("failed to connect: ", err)
            return
        end

        local req = "GET /local_ips HTTP/1.0\r\nHost: localhost\r\nConnection: close\r\n\r\n"
        local bytes, err = sock:send(req)

        if not bytes then
           log("failed to send request: ", err)
           return
        end

        while true do
            local line, err, part = sock:receive()
            if line then
                -- log("received: ", line)
            else
                -- ngx.say("failed to receive a line: ", err, " [", part, "]")
                break
            end
        end
	sock:close()

        local sock = ngx.socket.udp()
        local ok, err = sock:setpeername("report.gslb.letv.com", 8123)
        if not ok then
            log("failed to connect to gslb: ", err)
	    sock:close()
            return
        end

        local status_data_keys = {"local_ips", "nband", "hband", "ngx_stat_writing", "load", "wget", "pull_num", "push_num"}
        local status_data_vals = { }

        for _, key in ipairs(status_data_keys) do
            local val = status_report:get(key)
            val = (val and val) or 0
            table.insert(status_data_vals, val)
       end

        sock:send(table.concat(status_data_vals, ","))
	sock:close()

        local hc = http:new()
	local res, err = hc:request_uri("http://report.g5.letv.cn/report/heartbeat", {
                method = "POST",
                body = table.concat(status_data_vals, ","),
            })
	ngx.log(ngx.ERR, "status: ", res.status)

    end
end


r2h_report_func = function(premature)
    if not premature then
        local ok, err = new_timer(r2h_report_delay, r2h_report_func)

        if not ok then
            log(ERR, "failed to create timer: ", err)
            return
        end

        local now = ngx.time()
        local timestamp = os.date("%Y%m%d%H%M", now)
        local r2h_report = ngx.shared.r2h_report
        local hls_report = ngx.shared.hls_report
        local hls_report_stat = ngx.shared.hls_report_stat

        if not get_lock(r2h_report_delay, r2h_report) then
            return
        end

        local keys = r2h_report:get_keys(0)
        local r2h_report_data = ""

        if table.maxn(keys) > 1 then

            for i = 1, table.maxn(keys) do
                local key = keys[i]

                if key ~= "report_lock" then
                    local value = r2h_report:get(key)

                    r2h_report:delete(key)
                    r2h_report_data = r2h_report_data..key.."&timestamp="..timestamp.."&bw="..tostring(value).."\n"
                    local val_tab = {}
                    for k, v in string.gmatch(string.sub(r2h_report_data, 1, string.len(r2h_report_data) - 1), "(%w+)=([^&]+)") do
                        val_tab[k] = v
                    end

                    local sock = ngx.socket.udp()
                    local ok, err = sock:setpeername("127.0.0.1", 8121)
                    if not ok then
                        log("failed to connect to watchdog: ", err)
                        sock:close()
                        return
                    end

                    local log_format = {"server_addr", "remote_addr", "time_local", "request", "status", "body_bytes_sent", "bytes_sent", "content_length",
                     "proxyed", "host", "user_agent", "referer", "range", "ext1", "time", "ext2", "ext3", "ext4", "ext5", "ext6"}

                    val_tab["server_addr"] = val_tab["sip"] .. ":80"
                    val_tab["remote_addr"] = val_tab["cip"]
                    val_tab["time_local"] = os.date("%d/%b/%Y:%X +0800", os.time())
                    val_tab["request"] = "GET /live/hls/" .. val_tab["streamid"] .. ".flv?stream_id=" .. val_tab["streamid"] .. "&mltag=10102" .. " HTTP/1.1"
                    val_tab["status"] = "200"
                    val_tab["body_bytes_sent"] = tostring(val_tab["bw"])
                    val_tab["bytes_sent"] = tostring(val_tab["bw"])
                    val_tab["content_length"] = tostring(val_tab["bw"])
                    val_tab["proxyed"] = "HIT"
                    val_tab["host"] = val_tab["sip"]
                    val_tab["user_agent"] = "-"
                    val_tab["referer"] = "-"
                    val_tab["range"] = "-"
                    val_tab["ext1"] = "-"
                    val_tab["time"] = "60"
                    val_tab["ext2"] = "0"
                    val_tab["ext3"] = "-"
                    val_tab["ext4"] = "-"
                    val_tab["ext5"] = "-"
                    val_tab["ext6"] = "-"

                    local log = "<190>May 19 17:54:56 cdn-hb-lf-cnc-128 cdn_log_nginx:"

                    for i, j in ipairs(log_format) do
                        log = log .. " \"" .. val_tab[j] .. "\""
                    end


                    sock:send(log)
                    sock:close()
                end
            end



            local httpc = http.new()
            local res, err = httpc:request_uri("http://" .. report_host  .. r2h_report_uri, {
                method = "POST",
                body = r2h_report_data,
                headers = {
                    ["Host"] = report_host,
                }
            })

        end


        local keys = hls_report:get_keys(0)
        local hls_report_data = ""

        if table.maxn(keys) > 0 then

            for i = 1, table.maxn(keys) do
                local key = keys[i]

                if key ~= "report_lock" then
                    local bw  = hls_report:get(key)
                    local xx5 = hls_report_stat:get(key.."xx5")
                    local t0  = hls_report_stat:get(key.."t0")
                    local t3  = hls_report_stat:get(key.."t3")

                    xx5 = (xx5 and xx5) or 0
                    t0 = (t0 and t0) or 0
                    t3 = (t3 and t3) or 0

                    hls_report:delete(key)
                    hls_report_stat:delete(key.."xx5")
                    hls_report_stat:delete(key.."t0")
                    hls_report_stat:delete(key.."t3")

                    hls_report_data = hls_report_data..key.."&timestamp="..timestamp.."&bw="..tostring(bw)
                    hls_report_data = hls_report_data.."&t0="..tostring(t0).."&t3="..tostring(t3).."&xx5="..tostring(xx5).."\n"
                end
            end

            local httpc = http.new()
            local res, err = httpc:request_uri("http://" .. report_host  .. hls_report_uri, {
                    method = "POST",
                    body = hls_report_data,
                    headers = {
                        ["Host"] = report_host,
                   }
            })

            local ok, err = httpc:set_keepalive()

        end
    end
end

upstream_update_func = function(premature)
    if not premature then
        local ok, err = new_timer(upstream_delay, upstream_update_func)

        if not ok then
            log(ERR, "failed to create timer: ", err)
            return
        end

        local ups_config = ngx.shared.ups_config
        local config = ups_config:get("default")
        local leups = require "le.upstream"
        leups.update_upstream_status(config)
    end
end

local ok, err = new_timer(status_report_delay, status_report_func)
if not ok then
    log(ERR, "failed to create timer: ", err)
    return
end

local ok, err = new_timer(r2h_report_delay, r2h_report_func)
if not ok then
    log(ERR, "failed to create timer: ", err)
    return
end

local ok, err = new_timer(upstream_delay, upstream_update_func)
if not ok then
    log(ERR, "failed to create timer: ", err)
    return
end
