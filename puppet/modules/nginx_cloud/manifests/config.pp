class nginx_cloud::config {
    file {"/usr/local/nginx/conf/": ensure => directory, }
    file {"/usr/local/nginx/conf/app": ensure => directory, }
    file {"/usr/local/nginx/conf/cert": ensure => directory, }
    file {"/usr/local/nginx/conf/clives": ensure => directory, }
    file {"/usr/local/nginx/conf/domains": ensure => directory, }
    file {"/usr/local/nginx/conf/g3": ensure => directory, }
    file {"/usr/local/nginx/conf/letv": ensure => directory, }
    file {"/usr/local/nginx/conf/lua": ensure => directory, }
    file {"/usr/local/nginx/conf/lualib": ensure => directory, }
    file {"/usr/local/nginx/conf/lualib/le": ensure => directory, }
    file {"/usr/local/nginx/conf/lualib/net": ensure => directory, }
    file {"/usr/local/nginx/conf/lualib/ngx": ensure => directory, }
    file {"/usr/local/nginx/conf/lualib/resty": ensure => directory, }
    file {"/usr/local/nginx/conf/lualib/resty/core": ensure => directory, }
    file {"/usr/local/nginx/conf/lua_phase": ensure => directory, }
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
        content => template("nginx_cloud/50x.html"),
    }
    file {"/usr/local/nginx/html/index.html":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/index.html"),
    }
    file {"/usr/local/nginx/get_source.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/get_source.conf"),
    }
    file {"/usr/local/nginx/conf/app/content_handler.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/app/content_handler.lua"),
    }
    file {"/usr/local/nginx/conf/app/header_filter.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/app/header_filter.lua"),
    }
    file {"/usr/local/nginx/conf/app/init_cache.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/app/init_cache.lua"),
    }
    file {"/usr/local/nginx/conf/app/log_handler.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/app/log_handler.lua"),
    }
    file {"/usr/local/nginx/conf/app/rewrite_handler.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/app/rewrite_handler.lua"),
    }
    file {"/usr/local/nginx/conf/app/ups_config.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/app/ups_config.lua"),
    }
    file {"/usr/local/nginx/conf/app/upstream.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/app/upstream.lua"),
    }
    file {"/usr/local/nginx/conf/cert/all.crt":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/cert/all.crt"),
    }
    file {"/usr/local/nginx/conf/cert/all.key":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/cert/all.key"),
    }
    file {"/usr/local/nginx/conf/cert/localhost.crt":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/cert/localhost.crt"),
    }
    file {"/usr/local/nginx/conf/cert/localhost.key":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/cert/localhost.key"),
    }
    file {"/usr/local/nginx/conf/cert/tuyoo_com.key":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/cert/tuyoo_com.key"),
    }
    file {"/usr/local/nginx/conf/cert/tuyoo_com.pem":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/cert/tuyoo_com.pem"),
    }
    file {"/usr/local/nginx/conf/cert/wdjcdn_com.key":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/cert/wdjcdn_com.key"),
    }
    file {"/usr/local/nginx/conf/cert/wdjcdn_com.pem":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/cert/wdjcdn_com.pem"),
    }
    file {"/usr/local/nginx/conf/cert/ys7_com.key":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/cert/ys7_com.key"),
    }
    file {"/usr/local/nginx/conf/cert/ys7_com.pem":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/cert/ys7_com.pem"),
    }
    file {"/usr/local/nginx/conf/clives/clive_app.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/clives/clive_app.conf"),
    }
    file {"/usr/local/nginx/conf/clives/clive.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/clives/clive.conf"),
    }
    file {"/usr/local/nginx/conf/clives/server_5kong.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/clives/server_5kong.conf"),
    }
    file {"/usr/local/nginx/conf/clives/server_kukuplay.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/clives/server_kukuplay.conf"),
    }
    file {"/usr/local/nginx/conf/clives/server_momo.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/clives/server_momo.conf"),
    }
    file {"/usr/local/nginx/conf/clives/server_plls_wopaitv_com.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/clives/server_plls_wopaitv_com.conf"),
    }
    file {"/usr/local/nginx/conf/clives/server_showself.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/clives/server_showself.conf"),
    }
    file {"/usr/local/nginx/conf/clives/server_wisetv.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/clives/server_wisetv.conf"),
    }
    file {"/usr/local/nginx/conf/domains/acfun.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/acfun.conf"),
    }
    file {"/usr/local/nginx/conf/domains/aipai_com.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/aipai_com.conf"),
    }
    file {"/usr/local/nginx/conf/domains/atianqi.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/atianqi.conf"),
    }
    file {"/usr/local/nginx/conf/domains/baomihua_com.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/baomihua_com.conf"),
    }
    file {"/usr/local/nginx/conf/domains/chaoxing_referer.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/chaoxing_referer.conf"),
    }
    file {"/usr/local/nginx/conf/domains/clive_app.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/clive_app.conf"),
    }
    file {"/usr/local/nginx/conf/domains/clive.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/clive.conf"),
    }
    file {"/usr/local/nginx/conf/domains/clive_server_name.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/clive_server_name.conf"),
    }
    file {"/usr/local/nginx/conf/domains/clouddn.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/clouddn.conf"),
    }
    file {"/usr/local/nginx/conf/domains/coopcdn.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/coopcdn.conf"),
    }
    file {"/usr/local/nginx/conf/domains/coop_redirect.cfg":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/coop_redirect.cfg"),
    }
    file {"/usr/local/nginx/conf/domains/cuctv.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/cuctv.conf"),
    }
    file {"/usr/local/nginx/conf/domains/cutv.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/cutv.conf"),
    }
    file {"/usr/local/nginx/conf/domains/cztv_referer.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/cztv_referer.conf"),
    }
    file {"/usr/local/nginx/conf/domains/general_hls.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/general_hls.conf"),
    }
    file {"/usr/local/nginx/conf/domains/hntv.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/hntv.conf"),
    }
    file {"/usr/local/nginx/conf/domains/huan_tv.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/huan_tv.conf"),
    }
    file {"/usr/local/nginx/conf/domains/icntv.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/icntv.conf"),
    }
    file {"/usr/local/nginx/conf/domains/icntv_ua.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/icntv_ua.conf"),
    }
    file {"/usr/local/nginx/conf/domains/idol001_referer.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/idol001_referer.conf"),
    }
    file {"/usr/local/nginx/conf/domains/influxdb.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/influxdb.conf"),
    }
    file {"/usr/local/nginx/conf/domains/letv_cto.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/letv_cto.conf"),
    }
    file {"/usr/local/nginx/conf/domains/lizhi_fm.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/lizhi_fm.conf"),
    }
    file {"/usr/local/nginx/conf/domains/m1905.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/m1905.conf"),
    }
    file {"/usr/local/nginx/conf/domains/meipai.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/meipai.conf"),
    }
    file {"/usr/local/nginx/conf/domains/open.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/open.conf"),
    }
    file {"/usr/local/nginx/conf/domains/panda_tv.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/panda_tv.conf"),
    }
    file {"/usr/local/nginx/conf/domains/popcorn_com.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/popcorn_com.conf"),
    }
    file {"/usr/local/nginx/conf/domains/popcorn_referer.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/popcorn_referer.conf"),
    }
    file {"/usr/local/nginx/conf/domains/qiniu.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/qiniu.conf"),
    }
    file {"/usr/local/nginx/conf/domains/readtv.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/readtv.conf"),
    }
    file {"/usr/local/nginx/conf/domains/souhu.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/souhu.conf"),
    }
    file {"/usr/local/nginx/conf/domains/starschinalive.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/starschinalive.conf"),
    }
    file {"/usr/local/nginx/conf/domains/tuyoo_com.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/tuyoo_com.conf"),
    }
    file {"/usr/local/nginx/conf/domains/tvesou.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/tvesou.conf"),
    }
    file {"/usr/local/nginx/conf/domains/ucloud_com_cn.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/ucloud_com_cn.conf"),
    }
    file {"/usr/local/nginx/conf/domains/upuday_com.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/upuday_com.conf"),
    }
    file {"/usr/local/nginx/conf/domains/vlook_cn.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/vlook_cn.conf"),
    }
    file {"/usr/local/nginx/conf/domains/wasu_cn.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/wasu_cn.conf"),
    }
    file {"/usr/local/nginx/conf/domains/wasu.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/wasu.conf"),
    }
    file {"/usr/local/nginx/conf/domains/wdjcdn.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/domains/wdjcdn.conf"),
    }
    file {"/usr/local/nginx/conf/fastcgi.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/fastcgi.conf"),
    }
    file {"/usr/local/nginx/conf/fastcgi_params":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/fastcgi_params"),
    }
    file {"/usr/local/nginx/conf/g3/location_cztv.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/g3/location_cztv.conf"),
    }
    file {"/usr/local/nginx/conf/koi-utf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/koi-utf"),
    }
    file {"/usr/local/nginx/conf/koi-win":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/koi-win"),
    }
    file {"/usr/local/nginx/conf/letv/blackhole.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/letv/blackhole.conf"),
    }
    file {"/usr/local/nginx/conf/letv/credirect.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/letv/credirect.conf"),
    }
    file {"/usr/local/nginx/conf/letv/lecloudsecurity.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/letv/lecloudsecurity.conf"),
    }
    file {"/usr/local/nginx/conf/letv/letv_cto.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/letv/letv_cto.conf"),
    }
    file {"/usr/local/nginx/conf/letv/live.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/letv/live.conf"),
    }
    file {"/usr/local/nginx/conf/letv/live_security.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/letv/live_security.conf"),
    }
    file {"/usr/local/nginx/conf/letv/live_ts_security.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/letv/live_ts_security.conf"),
    }
    file {"/usr/local/nginx/conf/letv/rtmp_r2h.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/letv/rtmp_r2h.conf"),
    }
    file {"/usr/local/nginx/conf/letv/security.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/letv/security.conf"),
    }
    file {"/usr/local/nginx/conf/letv/set_var.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/letv/set_var.conf"),
    }
    file {"/usr/local/nginx/conf/letv/ts_security.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/letv/ts_security.conf"),
    }
    file {"/usr/local/nginx/conf/lua/anti_flowrate_control.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/anti_flowrate_control.lua"),
    }
    file {"/usr/local/nginx/conf/lua/cztv.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/cztv.lua"),
    }
    file {"/usr/local/nginx/conf/lua/dns_secure_link.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/dns_secure_link.lua"),
    }
    file {"/usr/local/nginx/conf/lua/gslb_cache.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/gslb_cache.lua"),
    }
    file {"/usr/local/nginx/conf/lua/hntv_m3u8.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/hntv_m3u8.lua"),
    }
    file {"/usr/local/nginx/conf/lua/hntv_report.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/hntv_report.lua"),
    }
    file {"/usr/local/nginx/conf/lua/init_worker.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/init_worker.lua"),
    }
    file {"/usr/local/nginx/conf/lua/lecloud_slice_purge.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/lecloud_slice_purge.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/le/upstream.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/le/upstream.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/lfs.so":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/lfs.so"),
    }
    file {"/usr/local/nginx/conf/lualib/net/url.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/net/url.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/ngx/balancer.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/ngx/balancer.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/ngx/ocsp.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/ngx/ocsp.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/ngx/semaphore.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/ngx/semaphore.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/ngx/ssl.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/ngx/ssl.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/request.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/request.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/base64.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/resty/core/base64.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/base.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/resty/core/base.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/ctx.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/resty/core/ctx.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/exit.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/resty/core/exit.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/hash.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/resty/core/hash.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/resty/core.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/misc.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/resty/core/misc.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/regex.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/resty/core/regex.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/request.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/resty/core/request.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/response.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/resty/core/response.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/shdict.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/resty/core/shdict.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/time.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/resty/core/time.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/uri.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/resty/core/uri.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/var.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/resty/core/var.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/worker.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/resty/core/worker.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/http_headers.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/resty/http_headers.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/http.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/resty/http.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/socket.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/socket.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/var.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lualib/var.lua"),
    }
    file {"/usr/local/nginx/conf/lua/limit_test.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/limit_test.lua"),
    }
    file {"/usr/local/nginx/conf/lua/live_flv_auth_cache.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/live_flv_auth_cache.lua"),
    }
    file {"/usr/local/nginx/conf/lua/live_flv_auth.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/live_flv_auth.lua"),
    }
    file {"/usr/local/nginx/conf/lua/live_flv_report.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/live_flv_report.lua"),
    }
    file {"/usr/local/nginx/conf/lua/live_gslb_cache.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/live_gslb_cache.lua"),
    }
    file {"/usr/local/nginx/conf/lua/live_hls_report.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/live_hls_report.lua"),
    }
    file {"/usr/local/nginx/conf/lua/live_rtmp_auth.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/live_rtmp_auth.lua"),
    }
    file {"/usr/local/nginx/conf/lua/local_ips.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/local_ips.lua"),
    }
    file {"/usr/local/nginx/conf/lua/pan_secure.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/pan_secure.lua"),
    }
    file {"/usr/local/nginx/conf/lua_phase/mod_bw3_dwstatic_com.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua_phase/mod_bw3_dwstatic_com.lua"),
    }
    file {"/usr/local/nginx/conf/lua_phase/mod_f3tm_f3key.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua_phase/mod_f3tm_f3key.lua"),
    }
    file {"/usr/local/nginx/conf/lua_phase/mod_lecloudoverseaswx_icntvcdn_com.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua_phase/mod_lecloudoverseaswx_icntvcdn_com.lua"),
    }
    file {"/usr/local/nginx/conf/lua_phase/mod_musiccdn_duohappy_cn.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua_phase/mod_musiccdn_duohappy_cn.lua"),
    }
    file {"/usr/local/nginx/conf/lua_phase/mod_ottvideoyd_hifuntv_com.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua_phase/mod_ottvideoyd_hifuntv_com.lua"),
    }
    file {"/usr/local/nginx/conf/lua_phase/mod_str_oversea001_icntvcdn_com.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua_phase/mod_str_oversea001_icntvcdn_com.lua"),
    }
    file {"/usr/local/nginx/conf/lua_phase/mod_test13_checknetwork_yy_com.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua_phase/mod_test13_checknetwork_yy_com.lua"),
    }
    file {"/usr/local/nginx/conf/lua_phase/mod_v10_pstatp_com.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua_phase/mod_v10_pstatp_com.lua"),
    }
    file {"/usr/local/nginx/conf/lua_phase/mod_wxyx_lszb_atianqi_com.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua_phase/mod_wxyx_lszb_atianqi_com.lua"),
    }
    file {"/usr/local/nginx/conf/lua/post_metadata_process.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/post_metadata_process.lua"),
    }
    file {"/usr/local/nginx/conf/lua/post_moov_process.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/post_moov_process.lua"),
    }
    file {"/usr/local/nginx/conf/lua/pre_metadata_process.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/pre_metadata_process.lua"),
    }
    file {"/usr/local/nginx/conf/lua/pre_moov_process.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/pre_moov_process.lua"),
    }
    file {"/usr/local/nginx/conf/lua/rtmp_connection.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/rtmp_connection.lua"),
    }
    file {"/usr/local/nginx/conf/lua/snmpband.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/snmpband.lua"),
    }
    file {"/usr/local/nginx/conf/lua/splatid_ctr.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/splatid_ctr.lua"),
    }
    file {"/usr/local/nginx/conf/lua/spost_moov_process.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/spost_moov_process.lua"),
    }
    file {"/usr/local/nginx/conf/lua/tvesou_secure.lua":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/lua/tvesou_secure.lua"),
    }
    file {"/usr/local/nginx/conf/mime.types":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/mime.types"),
    }
    file {"/usr/local/nginx/conf/nginx.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/nginx.conf"),
    }
    file {"/usr/local/nginx/conf/scgi_params":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/scgi_params"),
    }
    file {"/usr/local/nginx/conf/uwsgi_params":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/uwsgi_params"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_adown_myaora_net_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_adown_myaora_net_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_a_ext_download_cdnbtst_lecloud_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_a_ext_download_cdnbtst_lecloud_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_a_ext_vod_cdnbtst_lecloud_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_a_ext_vod_cdnbtst_lecloud_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_apk3_cdn_anzhi_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_apk3_cdn_anzhi_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_appdown_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_appdown_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_appstore-dl_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_appstore-dl_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_beta_unity3d_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_beta_unity3d_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_bw3_dwstatic_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_bw3_dwstatic_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cdn2_msg_tcloudfamily_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_cdn2_msg_tcloudfamily_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cdn5_lizhi_fm_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_cdn5_lizhi_fm_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cdnb_file_test_lecloud_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_cdnb_file_test_lecloud_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cdnb-newarch_test_lecloud_com.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_cdnb-newarch_test_lecloud_com.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cdn_enhancecms_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_cdn_enhancecms_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cdn_lecdn_huluxia_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_cdn_lecdn_huluxia_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cdn_lecloud_vcinema_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_cdn_lecloud_vcinema_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cdnleshi_miloli_info_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_cdnleshi_miloli_info_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cdn_myaora_net_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_cdn_myaora_net_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cdn_tvhuan_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_cdn_tvhuan_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cmmap_careland_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_cmmap_careland_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_coolyun.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_coolyun.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cztv_live.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_cztv_live.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cztv_vod.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_cztv_vod.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_d2_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_d2_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_d_app_huan_tv.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_d_app_huan_tv.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_d_app_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_d_app_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_d_appstoreh_atianqi_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_d_appstoreh_atianqi_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_d_appstore_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_d_appstore_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_d_app_tcl_hifuntv_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_d_app_tcl_hifuntv_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_dazenota_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_dazenota_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_d_chapp_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_d_chapp_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_dl_ch_hifuntv_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_dl_ch_hifuntv_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_dl_lsy_tclclouds_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_dl_lsy_tclclouds_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_dl_xyaz_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_dl_xyaz_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_dmnhk.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_dmnhk.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down10b_zol_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_down10b_zol_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down10c_zol_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_down10c_zol_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down10_zol_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_down10_zol_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down11t_zol_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_down11t_zol_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down3_weapp_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_down3_weapp_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down8b_zol_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_down8b_zol_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down8_zol_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_down8_zol_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down9b_zol_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_down9b_zol_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down9_zol_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_down9_zol_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_download1_healthmall_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_download1_healthmall_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_download2_ys7_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_download2_ys7_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_download_careland_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_download_careland_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_download_changhong_upgrade2_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_download_changhong_upgrade2_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_download_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_download_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_downloadf_dewmobile_net_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_downloadf_dewmobile_net_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_download-letv_golivetv_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_download-letv_golivetv_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down_sarrs_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_down_sarrs_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down_weapp_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_down_weapp_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_d_tclapp_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_d_tclapp_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_dv_spriteapp_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_dv_spriteapp_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_gameload_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_gameload_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_gdown_baidu_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_gdown_baidu_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_gg-m3u81_gole_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_gg-m3u81_gole_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_gg-m3u82_gole_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_gg-m3u82_gole_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_gg-test_goscreen_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_gg-test_goscreen_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_gongkao_download_duia_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_gongkao_download_duia_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_gvideo_le_my7v_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_gvideo_le_my7v_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_haocdnle_trafficmanager_cn.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_haocdnle_trafficmanager_cn.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_huan.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_huan.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_huan_mediacdn_cedock_net_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_huan_mediacdn_cedock_net_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_im_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_im_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_img01_xgmimg_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_img01_xgmimg_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_img2_cedock_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_img2_cedock_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_img_ads_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_img_ads_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_ivviota_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_ivviota_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_jiulian_odm_update_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_jiulian_odm_update_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k10_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_k10_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k12_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_k12_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k1_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_k1_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k245_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_k245_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k2_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_k2_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k3_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_k3_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k4_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_k4_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k5_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_k5_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k6_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_k6_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k8_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_k8_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k9_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_k9_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_kan2_video_anyan_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_kan2_video_anyan_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_kaopuyun.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_kaopuyun.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_le-apk_wdjcdn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_le-apk_wdjcdn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_lecloudcdn_myccdn_info_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_lecloudcdn_myccdn_info_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_lecloud_daxiangjia_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_lecloud_daxiangjia_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_lecloud_educdn_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_lecloud_educdn_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_lecloud_gamezonecdn_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_lecloud_gamezonecdn_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_lecloudoverseaswx_icntvcdn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_lecloudoverseaswx_icntvcdn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_ledownload_crimoon_net_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_ledownload_crimoon_net_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_le_game_oacg_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_le_game_oacg_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_leod_qingting_fm_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_leod_qingting_fm_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_les_waqu_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_les_waqu_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_letvblive_tvfan_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_letvblive_tvfan_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_letv_cdntest_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_letv_cdntest_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_letv_v_tvxio_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_letv_v_tvxio_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_le_v2_xiaoying_tv.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_le_v2_xiaoying_tv.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_lizhi.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_lizhi.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_ls_hls_ott_cibntv_net_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_ls_hls_ott_cibntv_net_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_lsm3u8_snctv_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_lsm3u8_snctv_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_m3u8-tw1_gole_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_m3u8-tw1_gole_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_m3u8-tw2_gole_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_m3u8-tw2_gole_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_mccdntest-samsung-letv_trafficmanager_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_mccdntest-samsung-letv_trafficmanager_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_media_ourteacher_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_media_ourteacher_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_meipai.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_meipai.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_ms_wifienjoy_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_ms_wifienjoy_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_musiccdn_duohappy_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_musiccdn_duohappy_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_ne-letv_v_tvxio_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_ne-letv_v_tvxio_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_newcdntest_cdnle_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_newcdntest_cdnle_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_ota_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_ota_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_otadownload_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_otadownload_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_otatest_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_otatest_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_ottvideoyd_hifuntv_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_ottvideoyd_hifuntv_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_ott_yunduan_cust_cdnbtst_lecloud_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_ott_yunduan_cust_cdnbtst_lecloud_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_pcdownyd_titan_mgtv_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_pcdownyd_titan_mgtv_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_pcvideoyd_titan_mgtv_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_pcvideoyd_titan_mgtv_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_qiniudn.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_qiniudn.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_resource_wifienjoy_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_resource_wifienjoy_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_res_zhuanzhuan888_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_res_zhuanzhuan888_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_sdown_myaora_net_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_sdown_myaora_net_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_shediao.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_shediao.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_sougou.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_sougou.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_stream1_grtn_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_stream1_grtn_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_str_oversea001_icntvcdn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_str_oversea001_icntvcdn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_sys-update_ch_hifuntv_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_sys-update_ch_hifuntv_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_tcdn_lovegamecenter_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_tcdn_lovegamecenter_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_test001_isurecloud_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_test001_isurecloud_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_test13_checknetwork_yy_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_test13_checknetwork_yy_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_testdownload_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_testdownload_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_testoppo_lecloud_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_testoppo_lecloud_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_test_yximgs.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_test_yximgs.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_trs-m3u81_gole_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_trs-m3u81_gole_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_tshop-oss_launcher_tcloudfamily_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_tshop-oss_launcher_tcloudfamily_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_tsl6_hls_cutv_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_tsl6_hls_cutv_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_tv12_audiocn_org_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_tv12_audiocn_org_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_tv245_audiocn_org_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_tv245_audiocn_org_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_ugcydzd.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_ugcydzd.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_update302_lejiao_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_update302_lejiao_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_update_cedock_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_update_cedock_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_update_lejiao_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_update_lejiao_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_v10_pstatp_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_v10_pstatp_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_v7a_pstatp_com.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_v7a_pstatp_com.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_vhalltest_cdnle_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_vhalltest_cdnle_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_video19_ifeng_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_video19_ifeng_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_video_carousel_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_video_carousel_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_video_le_my7v_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_video_le_my7v_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_Video_sarrs_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_Video_sarrs_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_vip_80166_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_vip_80166_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_v_lexiaobao_net_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_v_lexiaobao_net_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_vodhuad_sobeycache_com.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_vodhuad_sobeycache_com.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_vod-lecdn_dian_fm_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_vod-lecdn_dian_fm_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_vod_letvcdn_readtv_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_vod_letvcdn_readtv_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_w3_dwstatic_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_w3_dwstatic_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_wdjcdn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_wdjcdn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_wildcard_ext_download_cdnbtst_lecloud_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_wildcard_ext_download_cdnbtst_lecloud_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_wildcard_ext_vod_cdnbtst_lecloud_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_wildcard_ext_vod_cdnbtst_lecloud_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_wisetv.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_wisetv.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_wting_info_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_wting_info_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_wwd_mediacdn_cedock_net_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_wwd_mediacdn_cedock_net_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_www_microvirt_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_www_microvirt_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_wxyx_lszb_atianqi_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_wxyx_lszb_atianqi_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_xytv_hls_cutv_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_xytv_hls_cutv_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_ys7.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_ys7.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_yunduan_cdn_mojing_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_yunduan_cdn_mojing_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_zhenxian.conf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/vhosts/server_zhenxian.conf"),
    }
    file {"/usr/local/nginx/conf/win-utf":
        ensure => file,
        mode => 644,
        content => template("nginx_cloud/win-utf"),
    }
    file {"/usr/local/nginx/conf/lualib/socket/core.so":
        ensure => file,
        mode => 644,
        source => "puppet://$fileserver/nginx_cloud/core.so",
    }
    file {"/usr/local/nginx/conf/lualib/cjson.so":
        ensure => file,
        mode => 644,
        source => "puppet://$fileserver/nginx_cloud/cjson.so",
    }
    exec {"/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf -s reload":
        path => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
        subscribe => [
            File["/usr/local/nginx/conf/app/content_handler.lua"],
            File["/usr/local/nginx/conf/app/header_filter.lua"],
            File["/usr/local/nginx/conf/app/init_cache.lua"],
            File["/usr/local/nginx/conf/app/log_handler.lua"],
            File["/usr/local/nginx/conf/app/rewrite_handler.lua"],
            File["/usr/local/nginx/conf/app/ups_config.lua"],
            File["/usr/local/nginx/conf/app/upstream.lua"],
            File["/usr/local/nginx/conf/cert/all.crt"],
            File["/usr/local/nginx/conf/cert/all.key"],
            File["/usr/local/nginx/conf/cert/localhost.crt"],
            File["/usr/local/nginx/conf/cert/localhost.key"],
            File["/usr/local/nginx/conf/cert/tuyoo_com.key"],
            File["/usr/local/nginx/conf/cert/tuyoo_com.pem"],
            File["/usr/local/nginx/conf/cert/wdjcdn_com.key"],
            File["/usr/local/nginx/conf/cert/wdjcdn_com.pem"],
            File["/usr/local/nginx/conf/cert/ys7_com.key"],
            File["/usr/local/nginx/conf/cert/ys7_com.pem"],
            File["/usr/local/nginx/conf/clives/clive_app.conf"],
            File["/usr/local/nginx/conf/clives/clive.conf"],
            File["/usr/local/nginx/conf/clives/server_5kong.conf"],
            File["/usr/local/nginx/conf/clives/server_kukuplay.conf"],
            File["/usr/local/nginx/conf/clives/server_momo.conf"],
            File["/usr/local/nginx/conf/clives/server_plls_wopaitv_com.conf"],
            File["/usr/local/nginx/conf/clives/server_showself.conf"],
            File["/usr/local/nginx/conf/clives/server_wisetv.conf"],
            File["/usr/local/nginx/conf/domains/acfun.conf"],
            File["/usr/local/nginx/conf/domains/aipai_com.conf"],
            File["/usr/local/nginx/conf/domains/atianqi.conf"],
            File["/usr/local/nginx/conf/domains/baomihua_com.conf"],
            File["/usr/local/nginx/conf/domains/chaoxing_referer.conf"],
            File["/usr/local/nginx/conf/domains/clive_app.conf"],
            File["/usr/local/nginx/conf/domains/clive.conf"],
            File["/usr/local/nginx/conf/domains/clive_server_name.conf"],
            File["/usr/local/nginx/conf/domains/clouddn.conf"],
            File["/usr/local/nginx/conf/domains/coopcdn.conf"],
            File["/usr/local/nginx/conf/domains/coop_redirect.cfg"],
            File["/usr/local/nginx/conf/domains/cuctv.conf"],
            File["/usr/local/nginx/conf/domains/cutv.conf"],
            File["/usr/local/nginx/conf/domains/cztv_referer.conf"],
            File["/usr/local/nginx/conf/domains/general_hls.conf"],
            File["/usr/local/nginx/conf/domains/hntv.conf"],
            File["/usr/local/nginx/conf/domains/huan_tv.conf"],
            File["/usr/local/nginx/conf/domains/icntv.conf"],
            File["/usr/local/nginx/conf/domains/icntv_ua.conf"],
            File["/usr/local/nginx/conf/domains/idol001_referer.conf"],
            File["/usr/local/nginx/conf/domains/influxdb.conf"],
            File["/usr/local/nginx/conf/domains/letv_cto.conf"],
            File["/usr/local/nginx/conf/domains/lizhi_fm.conf"],
            File["/usr/local/nginx/conf/domains/m1905.conf"],
            File["/usr/local/nginx/conf/domains/meipai.conf"],
            File["/usr/local/nginx/conf/domains/open.conf"],
            File["/usr/local/nginx/conf/domains/panda_tv.conf"],
            File["/usr/local/nginx/conf/domains/popcorn_com.conf"],
            File["/usr/local/nginx/conf/domains/popcorn_referer.conf"],
            File["/usr/local/nginx/conf/domains/qiniu.conf"],
            File["/usr/local/nginx/conf/domains/readtv.conf"],
            File["/usr/local/nginx/conf/domains/souhu.conf"],
            File["/usr/local/nginx/conf/domains/starschinalive.conf"],
            File["/usr/local/nginx/conf/domains/tuyoo_com.conf"],
            File["/usr/local/nginx/conf/domains/tvesou.conf"],
            File["/usr/local/nginx/conf/domains/ucloud_com_cn.conf"],
            File["/usr/local/nginx/conf/domains/upuday_com.conf"],
            File["/usr/local/nginx/conf/domains/vlook_cn.conf"],
            File["/usr/local/nginx/conf/domains/wasu_cn.conf"],
            File["/usr/local/nginx/conf/domains/wasu.conf"],
            File["/usr/local/nginx/conf/domains/wdjcdn.conf"],
            File["/usr/local/nginx/conf/fastcgi.conf"],
            File["/usr/local/nginx/conf/fastcgi_params"],
            File["/usr/local/nginx/conf/g3/location_cztv.conf"],
            File["/usr/local/nginx/conf/koi-utf"],
            File["/usr/local/nginx/conf/koi-win"],
            File["/usr/local/nginx/conf/letv/blackhole.conf"],
            File["/usr/local/nginx/conf/letv/credirect.conf"],
            File["/usr/local/nginx/conf/letv/lecloudsecurity.conf"],
            File["/usr/local/nginx/conf/letv/letv_cto.conf"],
            File["/usr/local/nginx/conf/letv/live.conf"],
            File["/usr/local/nginx/conf/letv/live_security.conf"],
            File["/usr/local/nginx/conf/letv/live_ts_security.conf"],
            File["/usr/local/nginx/conf/letv/rtmp_r2h.conf"],
            File["/usr/local/nginx/conf/letv/security.conf"],
            File["/usr/local/nginx/conf/letv/set_var.conf"],
            File["/usr/local/nginx/conf/letv/ts_security.conf"],
            File["/usr/local/nginx/conf/lua/anti_flowrate_control.lua"],
            File["/usr/local/nginx/conf/lua/cztv.lua"],
            File["/usr/local/nginx/conf/lua/dns_secure_link.lua"],
            File["/usr/local/nginx/conf/lua/gslb_cache.lua"],
            File["/usr/local/nginx/conf/lua/hntv_m3u8.lua"],
            File["/usr/local/nginx/conf/lua/hntv_report.lua"],
            File["/usr/local/nginx/conf/lua/init_worker.lua"],
            File["/usr/local/nginx/conf/lua/lecloud_slice_purge.lua"],
            File["/usr/local/nginx/conf/lualib/le/upstream.lua"],
            File["/usr/local/nginx/conf/lualib/lfs.so"],
            File["/usr/local/nginx/conf/lualib/net/url.lua"],
            File["/usr/local/nginx/conf/lualib/ngx/balancer.lua"],
            File["/usr/local/nginx/conf/lualib/ngx/ocsp.lua"],
            File["/usr/local/nginx/conf/lualib/ngx/semaphore.lua"],
            File["/usr/local/nginx/conf/lualib/ngx/ssl.lua"],
            File["/usr/local/nginx/conf/lualib/request.lua"],
            File["/usr/local/nginx/conf/lualib/resty/core/base64.lua"],
            File["/usr/local/nginx/conf/lualib/resty/core/base.lua"],
            File["/usr/local/nginx/conf/lualib/resty/core/ctx.lua"],
            File["/usr/local/nginx/conf/lualib/resty/core/exit.lua"],
            File["/usr/local/nginx/conf/lualib/resty/core/hash.lua"],
            File["/usr/local/nginx/conf/lualib/resty/core.lua"],
            File["/usr/local/nginx/conf/lualib/resty/core/misc.lua"],
            File["/usr/local/nginx/conf/lualib/resty/core/regex.lua"],
            File["/usr/local/nginx/conf/lualib/resty/core/request.lua"],
            File["/usr/local/nginx/conf/lualib/resty/core/response.lua"],
            File["/usr/local/nginx/conf/lualib/resty/core/shdict.lua"],
            File["/usr/local/nginx/conf/lualib/resty/core/time.lua"],
            File["/usr/local/nginx/conf/lualib/resty/core/uri.lua"],
            File["/usr/local/nginx/conf/lualib/resty/core/var.lua"],
            File["/usr/local/nginx/conf/lualib/resty/core/worker.lua"],
            File["/usr/local/nginx/conf/lualib/resty/http_headers.lua"],
            File["/usr/local/nginx/conf/lualib/resty/http.lua"],
            File["/usr/local/nginx/conf/lualib/socket.lua"],
            File["/usr/local/nginx/conf/lualib/var.lua"],
            File["/usr/local/nginx/conf/lua/limit_test.lua"],
            File["/usr/local/nginx/conf/lua/live_flv_auth_cache.lua"],
            File["/usr/local/nginx/conf/lua/live_flv_auth.lua"],
            File["/usr/local/nginx/conf/lua/live_flv_report.lua"],
            File["/usr/local/nginx/conf/lua/live_gslb_cache.lua"],
            File["/usr/local/nginx/conf/lua/live_hls_report.lua"],
            File["/usr/local/nginx/conf/lua/live_rtmp_auth.lua"],
            File["/usr/local/nginx/conf/lua/local_ips.lua"],
            File["/usr/local/nginx/conf/lua/pan_secure.lua"],
            File["/usr/local/nginx/conf/lua_phase/mod_bw3_dwstatic_com.lua"],
            File["/usr/local/nginx/conf/lua_phase/mod_f3tm_f3key.lua"],
            File["/usr/local/nginx/conf/lua_phase/mod_lecloudoverseaswx_icntvcdn_com.lua"],
            File["/usr/local/nginx/conf/lua_phase/mod_musiccdn_duohappy_cn.lua"],
            File["/usr/local/nginx/conf/lua_phase/mod_ottvideoyd_hifuntv_com.lua"],
            File["/usr/local/nginx/conf/lua_phase/mod_str_oversea001_icntvcdn_com.lua"],
            File["/usr/local/nginx/conf/lua_phase/mod_test13_checknetwork_yy_com.lua"],
            File["/usr/local/nginx/conf/lua_phase/mod_v10_pstatp_com.lua"],
            File["/usr/local/nginx/conf/lua_phase/mod_wxyx_lszb_atianqi_com.lua"],
            File["/usr/local/nginx/conf/lua/post_metadata_process.lua"],
            File["/usr/local/nginx/conf/lua/post_moov_process.lua"],
            File["/usr/local/nginx/conf/lua/pre_metadata_process.lua"],
            File["/usr/local/nginx/conf/lua/pre_moov_process.lua"],
            File["/usr/local/nginx/conf/lua/rtmp_connection.lua"],
            File["/usr/local/nginx/conf/lua/snmpband.lua"],
            File["/usr/local/nginx/conf/lua/splatid_ctr.lua"],
            File["/usr/local/nginx/conf/lua/spost_moov_process.lua"],
            File["/usr/local/nginx/conf/lua/tvesou_secure.lua"],
            File["/usr/local/nginx/conf/mime.types"],
            File["/usr/local/nginx/conf/nginx.conf"],
            File["/usr/local/nginx/conf/scgi_params"],
            File["/usr/local/nginx/conf/uwsgi_params"],
            File["/usr/local/nginx/conf/vhosts/server_adown_myaora_net_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_a_ext_download_cdnbtst_lecloud_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_a_ext_vod_cdnbtst_lecloud_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_apk3_cdn_anzhi_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_appdown_coolyun_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_appstore-dl_coolyun_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_beta_unity3d_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_bw3_dwstatic_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_cdn2_msg_tcloudfamily_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_cdn5_lizhi_fm_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_cdnb_file_test_lecloud_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_cdnb-newarch_test_lecloud_com.conf"],
            File["/usr/local/nginx/conf/vhosts/server_cdn_enhancecms_huan_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_cdn_lecdn_huluxia_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_cdn_lecloud_vcinema_com_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_cdnleshi_miloli_info_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_cdn_myaora_net_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_cdn_tvhuan_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_cmmap_careland_com_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_coolyun.conf"],
            File["/usr/local/nginx/conf/vhosts/server_cztv_live.conf"],
            File["/usr/local/nginx/conf/vhosts/server_cztv_vod.conf"],
            File["/usr/local/nginx/conf/vhosts/server_d2_coolyun_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_d_app_huan_tv.conf"],
            File["/usr/local/nginx/conf/vhosts/server_d_app_huan_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_d_appstoreh_atianqi_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_d_appstore_huan_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_d_app_tcl_hifuntv_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_dazenota_coolyun_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_d_chapp_huan_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_dl_ch_hifuntv_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_dl_lsy_tclclouds_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_dl_xyaz_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_dmnhk.conf"],
            File["/usr/local/nginx/conf/vhosts/server_down10b_zol_com_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_down10c_zol_com_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_down10_zol_com_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_down11t_zol_com_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_down3_weapp_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_down8b_zol_com_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_down8_zol_com_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_down9b_zol_com_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_down9_zol_com_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_download1_healthmall_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_download2_ys7_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_download_careland_com_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_download_changhong_upgrade2_huan_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_download_coolyun_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_downloadf_dewmobile_net_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_download-letv_golivetv_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_down_sarrs_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_down_weapp_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_d_tclapp_huan_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_dv_spriteapp_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_gameload_coolyun_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_gdown_baidu_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_gg-m3u81_gole_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_gg-m3u82_gole_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_gg-test_goscreen_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_gongkao_download_duia_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_gvideo_le_my7v_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_haocdnle_trafficmanager_cn.conf"],
            File["/usr/local/nginx/conf/vhosts/server_huan.conf"],
            File["/usr/local/nginx/conf/vhosts/server_huan_mediacdn_cedock_net_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_im_coolyun_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_img01_xgmimg_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_img2_cedock_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_img_ads_huan_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_ivviota_coolyun_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_jiulian_odm_update_huan_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_k10_audiocn_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_k12_audiocn_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_k1_audiocn_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_k245_audiocn_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_k2_audiocn_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_k3_audiocn_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_k4_audiocn_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_k5_audiocn_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_k6_audiocn_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_k8_audiocn_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_k9_audiocn_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_kan2_video_anyan_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_kaopuyun.conf"],
            File["/usr/local/nginx/conf/vhosts/server_le-apk_wdjcdn_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_lecloudcdn_myccdn_info_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_lecloud_daxiangjia_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_lecloud_educdn_huan_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_lecloud_gamezonecdn_huan_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_lecloudoverseaswx_icntvcdn_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_ledownload_crimoon_net_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_le_game_oacg_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_leod_qingting_fm_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_les_waqu_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_letvblive_tvfan_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_letv_cdntest_huan_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_letv_v_tvxio_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_le_v2_xiaoying_tv.conf"],
            File["/usr/local/nginx/conf/vhosts/server_lizhi.conf"],
            File["/usr/local/nginx/conf/vhosts/server_ls_hls_ott_cibntv_net_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_lsm3u8_snctv_com_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_m3u8-tw1_gole_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_m3u8-tw2_gole_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_mccdntest-samsung-letv_trafficmanager_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_media_ourteacher_com_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_meipai.conf"],
            File["/usr/local/nginx/conf/vhosts/server_ms_wifienjoy_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_musiccdn_duohappy_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_ne-letv_v_tvxio_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_newcdntest_cdnle_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_ota_coolyun_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_otadownload_coolyun_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_otatest_coolyun_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_ottvideoyd_hifuntv_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_ott_yunduan_cust_cdnbtst_lecloud_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_pcdownyd_titan_mgtv_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_pcvideoyd_titan_mgtv_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_qiniudn.conf"],
            File["/usr/local/nginx/conf/vhosts/server_resource_wifienjoy_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_res_zhuanzhuan888_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_sdown_myaora_net_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_shediao.conf"],
            File["/usr/local/nginx/conf/vhosts/server_sougou.conf"],
            File["/usr/local/nginx/conf/vhosts/server_stream1_grtn_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_str_oversea001_icntvcdn_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_sys-update_ch_hifuntv_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_tcdn_lovegamecenter_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_test001_isurecloud_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_test13_checknetwork_yy_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_testdownload_coolyun_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_testoppo_lecloud_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_test_yximgs.conf"],
            File["/usr/local/nginx/conf/vhosts/server_trs-m3u81_gole_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_tshop-oss_launcher_tcloudfamily_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_tsl6_hls_cutv_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_tv12_audiocn_org_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_tv245_audiocn_org_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_ugcydzd.conf"],
            File["/usr/local/nginx/conf/vhosts/server_update302_lejiao_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_update_cedock_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_update_lejiao_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_v10_pstatp_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_v7a_pstatp_com.conf"],
            File["/usr/local/nginx/conf/vhosts/server_vhalltest_cdnle_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_video19_ifeng_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_video_carousel_huan_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_video_le_my7v_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_Video_sarrs_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_vip_80166_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_v_lexiaobao_net_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_vodhuad_sobeycache_com.conf"],
            File["/usr/local/nginx/conf/vhosts/server_vod-lecdn_dian_fm_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_vod_letvcdn_readtv_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_w3_dwstatic_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_wdjcdn_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_wildcard_ext_download_cdnbtst_lecloud_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_wildcard_ext_vod_cdnbtst_lecloud_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_wisetv.conf"],
            File["/usr/local/nginx/conf/vhosts/server_wting_info_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_wwd_mediacdn_cedock_net_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_www_microvirt_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_wxyx_lszb_atianqi_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_xytv_hls_cutv_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_ys7.conf"],
            File["/usr/local/nginx/conf/vhosts/server_yunduan_cdn_mojing_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_zhenxian.conf"],
            File["/usr/local/nginx/conf/win-utf"],
            File["/usr/local/nginx/conf/lualib/socket/core.so"],
            File["/usr/local/nginx/conf/lualib/cjson.so"],
        ],
        onlyif => '/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf -t',
        refreshonly => true,
    }
}