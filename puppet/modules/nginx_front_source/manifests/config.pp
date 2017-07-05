class nginx_front_source::config {
    file {"/usr/local/nginx/conf/": ensure => directory, }
    file {"/usr/local/nginx/conf/app": ensure => directory, }
    file {"/usr/local/nginx/conf/cert": ensure => directory, }
    file {"/usr/local/nginx/conf/domains": ensure => directory, }
    file {"/usr/local/nginx/conf/lua": ensure => directory, }
    file {"/usr/local/nginx/conf/lualib": ensure => directory, }
    file {"/usr/local/nginx/conf/lualib/net": ensure => directory, }
    file {"/usr/local/nginx/conf/lualib/resty": ensure => directory, }
    file {"/usr/local/nginx/conf/lualib/resty/upstream": ensure => directory, }
    file {"/usr/local/nginx": ensure => directory, }
    file {"/usr/local/nginx/logs": ensure => directory, }
    file {"/usr/local/nginx/sbin": ensure => directory, }
    file {"/usr/local/nginx/html": ensure => directory, }
    file {"/usr/local/nginx/conf/opscfg": ensure => directory, }
    file {"/usr/local/nginx/conf/lualib/socket/": ensure => directory, }
    file {"/usr/local/nginx/conf/vhosts": ensure => directory, owner => consul, }
    file {"/usr/local/nginx/html/50x.html":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/50x.html"),
    }
    file {"/usr/local/nginx/html/index.html":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/index.html"),
    }
    file {"/usr/local/nginx/get_source.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/get_source.conf"),
    }
    file {"/usr/local/nginx/conf/app/content_handler.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/app/content_handler.lua"),
    }
    file {"/usr/local/nginx/conf/app/header_filter.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/app/header_filter.lua"),
    }
    file {"/usr/local/nginx/conf/app/init_cache.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/app/init_cache.lua"),
    }
    file {"/usr/local/nginx/conf/app/log_handler.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/app/log_handler.lua"),
    }
    file {"/usr/local/nginx/conf/app/ups_config.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/app/ups_config.lua"),
    }
    file {"/usr/local/nginx/conf/app/upstream.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/app/upstream.lua"),
    }
    file {"/usr/local/nginx/conf/cert/localhost.crt":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/cert/localhost.crt"),
    }
    file {"/usr/local/nginx/conf/cert/localhost.key":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/cert/localhost.key"),
    }
    file {"/usr/local/nginx/conf/cert/tuyoo_com.key":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/cert/tuyoo_com.key"),
    }
    file {"/usr/local/nginx/conf/cert/tuyoo_com.pem":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/cert/tuyoo_com.pem"),
    }
    file {"/usr/local/nginx/conf/cert/wdjcdn_com.key":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/cert/wdjcdn_com.key"),
    }
    file {"/usr/local/nginx/conf/cert/wdjcdn_com.pem":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/cert/wdjcdn_com.pem"),
    }
    file {"/usr/local/nginx/conf/domains/coopcdn.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/domains/coopcdn.conf"),
    }
    file {"/usr/local/nginx/conf/domains/cztvcom.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/domains/cztvcom.conf"),
    }
    file {"/usr/local/nginx/conf/domains/opencom.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/domains/opencom.conf"),
    }
    file {"/usr/local/nginx/conf/fastcgi.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/fastcgi.conf"),
    }
    file {"/usr/local/nginx/conf/fastcgi_params":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/fastcgi_params"),
    }
    file {"/usr/local/nginx/conf/koi-utf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/koi-utf"),
    }
    file {"/usr/local/nginx/conf/koi-win":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/koi-win"),
    }
    file {"/usr/local/nginx/conf/lua/dns_secure_link.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lua/dns_secure_link.lua"),
    }
    file {"/usr/local/nginx/conf/lua/gslb_cache.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lua/gslb_cache.lua"),
    }
    file {"/usr/local/nginx/conf/lua/hntv_m3u8.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lua/hntv_m3u8.lua"),
    }
    file {"/usr/local/nginx/conf/lua/hntv_report.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lua/hntv_report.lua"),
    }
    file {"/usr/local/nginx/conf/lua/init_worker.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lua/init_worker.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/init_worker.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lualib/init_worker.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/net/url.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lualib/net/url.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/request.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lualib/request.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/http_headers.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lualib/resty/http_headers.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/http.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lualib/resty/http.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/upstream/healthcheck.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lualib/resty/upstream/healthcheck.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/socket.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lualib/socket.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/var.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lualib/var.lua"),
    }
    file {"/usr/local/nginx/conf/lua/limit_test.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lua/limit_test.lua"),
    }
    file {"/usr/local/nginx/conf/lua/live_flv_auth.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lua/live_flv_auth.lua"),
    }
    file {"/usr/local/nginx/conf/lua/live_flv_report.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lua/live_flv_report.lua"),
    }
    file {"/usr/local/nginx/conf/lua/live_gslb_cache.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lua/live_gslb_cache.lua"),
    }
    file {"/usr/local/nginx/conf/lua/live_hls_report.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lua/live_hls_report.lua"),
    }
    file {"/usr/local/nginx/conf/lua/live_rtmp_auth.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lua/live_rtmp_auth.lua"),
    }
    file {"/usr/local/nginx/conf/lua/local_ips.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lua/local_ips.lua"),
    }
    file {"/usr/local/nginx/conf/lua/pan_secure.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lua/pan_secure.lua"),
    }
    file {"/usr/local/nginx/conf/lua/rtmp_connection.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lua/rtmp_connection.lua"),
    }
    file {"/usr/local/nginx/conf/lua/snmpband.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lua/snmpband.lua"),
    }
    file {"/usr/local/nginx/conf/lua/splatid_ctr.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lua/splatid_ctr.lua"),
    }
    file {"/usr/local/nginx/conf/lua/tvesou_secure.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/lua/tvesou_secure.lua"),
    }
    file {"/usr/local/nginx/conf/mime.types":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/mime.types"),
    }
    file {"/usr/local/nginx/conf/nginx.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/nginx.conf"),
    }
    file {"/usr/local/nginx/conf/scgi_params":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/scgi_params"),
    }
    file {"/usr/local/nginx/conf/set_var.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/set_var.conf"),
    }
    file {"/usr/local/nginx/conf/uwsgi_params":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/uwsgi_params"),
    }
    file {"/usr/local/nginx/conf/vhosts/aipai_com.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/vhosts/aipai_com.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/coolyun.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/vhosts/coolyun.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/coopcdn_wildcard.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/vhosts/coopcdn_wildcard.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/dsvideo_ott_cibntv_net.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/vhosts/dsvideo_ott_cibntv_net.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/ifunplus_cn.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/vhosts/ifunplus_cn.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/imgo.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/vhosts/imgo.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/letv_cto.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/vhosts/letv_cto.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/meipai.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/vhosts/meipai.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/miaopai.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/vhosts/miaopai.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_lecloud_daxiangjia_com_y.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/vhosts/server_lecloud_daxiangjia_com_y.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_le_v2_xiaoying_tv.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/vhosts/server_le_v2_xiaoying_tv.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_test_lecloud_com.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/vhosts/server_test_lecloud_com.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_test_yximgs.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/vhosts/server_test_yximgs.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_v10_pstatp_com_y.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/vhosts/server_v10_pstatp_com_y.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_v7a_pstatp_com.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/vhosts/server_v7a_pstatp_com.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/sobey_com.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/vhosts/sobey_com.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/trafficmanager.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/vhosts/trafficmanager.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/ucloud_com_cn.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/vhosts/ucloud_com_cn.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/upuday_com.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/vhosts/upuday_com.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/ys7.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/vhosts/ys7.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/yximgs.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/vhosts/yximgs.conf"),
    }
    file {"/usr/local/nginx/conf/win-utf":
        ensure => file,
        mode => 644,
        content => template("nginx_front_source/win-utf"),
    }
    file {"/usr/local/nginx/conf/lualib/socket/core.so":
        ensure => file,
        mode => 644,
        source => "puppet://$fileserver/nginx_front_source/core.so",
    }
    file {"/usr/local/nginx/conf/lualib/cjson.so":
        ensure => file,
        mode => 644,
        source => "puppet://$fileserver/nginx_front_source/cjson.so",
    }
    exec {"/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf -s reload":
        path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
        subscribe => [
            File["/usr/local/nginx/conf/app/content_handler.lua"],
            File["/usr/local/nginx/conf/app/header_filter.lua"],
            File["/usr/local/nginx/conf/app/init_cache.lua"],
            File["/usr/local/nginx/conf/app/log_handler.lua"],
            File["/usr/local/nginx/conf/app/ups_config.lua"],
            File["/usr/local/nginx/conf/app/upstream.lua"],
            File["/usr/local/nginx/conf/cert/localhost.crt"],
            File["/usr/local/nginx/conf/cert/localhost.key"],
            File["/usr/local/nginx/conf/cert/tuyoo_com.key"],
            File["/usr/local/nginx/conf/cert/tuyoo_com.pem"],
            File["/usr/local/nginx/conf/cert/wdjcdn_com.key"],
            File["/usr/local/nginx/conf/cert/wdjcdn_com.pem"],
            File["/usr/local/nginx/conf/domains/coopcdn.conf"],
            File["/usr/local/nginx/conf/domains/cztvcom.conf"],
            File["/usr/local/nginx/conf/domains/opencom.conf"],
            File["/usr/local/nginx/conf/fastcgi.conf"],
            File["/usr/local/nginx/conf/fastcgi_params"],
            File["/usr/local/nginx/conf/koi-utf"],
            File["/usr/local/nginx/conf/koi-win"],
            File["/usr/local/nginx/conf/lua/dns_secure_link.lua"],
            File["/usr/local/nginx/conf/lua/gslb_cache.lua"],
            File["/usr/local/nginx/conf/lua/hntv_m3u8.lua"],
            File["/usr/local/nginx/conf/lua/hntv_report.lua"],
            File["/usr/local/nginx/conf/lua/init_worker.lua"],
            File["/usr/local/nginx/conf/lualib/init_worker.lua"],
            File["/usr/local/nginx/conf/lualib/net/url.lua"],
            File["/usr/local/nginx/conf/lualib/request.lua"],
            File["/usr/local/nginx/conf/lualib/resty/http_headers.lua"],
            File["/usr/local/nginx/conf/lualib/resty/http.lua"],
            File["/usr/local/nginx/conf/lualib/resty/upstream/healthcheck.lua"],
            File["/usr/local/nginx/conf/lualib/socket.lua"],
            File["/usr/local/nginx/conf/lualib/var.lua"],
            File["/usr/local/nginx/conf/lua/limit_test.lua"],
            File["/usr/local/nginx/conf/lua/live_flv_auth.lua"],
            File["/usr/local/nginx/conf/lua/live_flv_report.lua"],
            File["/usr/local/nginx/conf/lua/live_gslb_cache.lua"],
            File["/usr/local/nginx/conf/lua/live_hls_report.lua"],
            File["/usr/local/nginx/conf/lua/live_rtmp_auth.lua"],
            File["/usr/local/nginx/conf/lua/local_ips.lua"],
            File["/usr/local/nginx/conf/lua/pan_secure.lua"],
            File["/usr/local/nginx/conf/lua/rtmp_connection.lua"],
            File["/usr/local/nginx/conf/lua/snmpband.lua"],
            File["/usr/local/nginx/conf/lua/splatid_ctr.lua"],
            File["/usr/local/nginx/conf/lua/tvesou_secure.lua"],
            File["/usr/local/nginx/conf/mime.types"],
            File["/usr/local/nginx/conf/nginx.conf"],
            File["/usr/local/nginx/conf/scgi_params"],
            File["/usr/local/nginx/conf/set_var.conf"],
            File["/usr/local/nginx/conf/uwsgi_params"],
            File["/usr/local/nginx/conf/vhosts/aipai_com.conf"],
            File["/usr/local/nginx/conf/vhosts/coolyun.conf"],
            File["/usr/local/nginx/conf/vhosts/coopcdn_wildcard.conf"],
            File["/usr/local/nginx/conf/vhosts/dsvideo_ott_cibntv_net.conf"],
            File["/usr/local/nginx/conf/vhosts/ifunplus_cn.conf"],
            File["/usr/local/nginx/conf/vhosts/imgo.conf"],
            File["/usr/local/nginx/conf/vhosts/letv_cto.conf"],
            File["/usr/local/nginx/conf/vhosts/meipai.conf"],
            File["/usr/local/nginx/conf/vhosts/miaopai.conf"],
            File["/usr/local/nginx/conf/vhosts/server_lecloud_daxiangjia_com_y.conf"],
            File["/usr/local/nginx/conf/vhosts/server_le_v2_xiaoying_tv.conf"],
            File["/usr/local/nginx/conf/vhosts/server_test_lecloud_com.conf"],
            File["/usr/local/nginx/conf/vhosts/server_test_yximgs.conf"],
            File["/usr/local/nginx/conf/vhosts/server_v10_pstatp_com_y.conf"],
            File["/usr/local/nginx/conf/vhosts/server_v7a_pstatp_com.conf"],
            File["/usr/local/nginx/conf/vhosts/sobey_com.conf"],
            File["/usr/local/nginx/conf/vhosts/trafficmanager.conf"],
            File["/usr/local/nginx/conf/vhosts/ucloud_com_cn.conf"],
            File["/usr/local/nginx/conf/vhosts/upuday_com.conf"],
            File["/usr/local/nginx/conf/vhosts/ys7.conf"],
            File["/usr/local/nginx/conf/vhosts/yximgs.conf"],
            File["/usr/local/nginx/conf/win-utf"],
            File["/usr/local/nginx/conf/lualib/socket/core.so"],
            File["/usr/local/nginx/conf/lualib/cjson.so"],
        ],
        onlyif => '/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf -t',
        refreshonly => true,
    }
}
