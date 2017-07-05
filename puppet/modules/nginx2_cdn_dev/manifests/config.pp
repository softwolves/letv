class nginx2_cdn_dev::config {
    file {"/usr/local/nginx/conf/": ensure => directory, }
    file {"/usr/local/nginx/conf/app": ensure => directory, }
    file {"/usr/local/nginx/conf/cert": ensure => directory, }
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
        content => template("nginx2_cdn_dev/50x.html"),
    }
    file {"/usr/local/nginx/html/index.html":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/index.html"),
    }
    file {"/usr/local/nginx/get_source.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/get_source.conf"),
    }
    file {"/usr/local/nginx/conf/app/content_handler.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/app/content_handler.lua"),
    }
    file {"/usr/local/nginx/conf/app/header_filter.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/app/header_filter.lua"),
    }
    file {"/usr/local/nginx/conf/app/init_cache.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/app/init_cache.lua"),
    }
    file {"/usr/local/nginx/conf/app/log_handler.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/app/log_handler.lua"),
    }
    file {"/usr/local/nginx/conf/app/rewrite_handler.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/app/rewrite_handler.lua"),
    }
    file {"/usr/local/nginx/conf/app/ups_config.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/app/ups_config.lua"),
    }
    file {"/usr/local/nginx/conf/app/upstream.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/app/upstream.lua"),
    }
    file {"/usr/local/nginx/conf/cert/all.crt":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/cert/all.crt"),
    }
    file {"/usr/local/nginx/conf/cert/all.key":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/cert/all.key"),
    }
    file {"/usr/local/nginx/conf/cert/localhost.crt":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/cert/localhost.crt"),
    }
    file {"/usr/local/nginx/conf/cert/localhost.key":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/cert/localhost.key"),
    }
    file {"/usr/local/nginx/conf/cert/ys7_com.key":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/cert/ys7_com.key"),
    }
    file {"/usr/local/nginx/conf/cert/ys7_com.pem":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/cert/ys7_com.pem"),
    }
    file {"/usr/local/nginx/conf/fastcgi.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/fastcgi.conf"),
    }
    file {"/usr/local/nginx/conf/fastcgi_params":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/fastcgi_params"),
    }
    file {"/usr/local/nginx/conf/koi-utf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/koi-utf"),
    }
    file {"/usr/local/nginx/conf/koi-win":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/koi-win"),
    }
    file {"/usr/local/nginx/conf/lua/dns_secure_link.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua/dns_secure_link.lua"),
    }
    file {"/usr/local/nginx/conf/lua/hntv_m3u8.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua/hntv_m3u8.lua"),
    }
    file {"/usr/local/nginx/conf/lua/hntv_report.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua/hntv_report.lua"),
    }
    file {"/usr/local/nginx/conf/lua/init_worker.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua/init_worker.lua"),
    }
    file {"/usr/local/nginx/conf/lua/lecloud_slice_purge.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua/lecloud_slice_purge.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/le/upstream.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/le/upstream.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/lfs.so":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/lfs.so"),
    }
    file {"/usr/local/nginx/conf/lualib/net/url.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/net/url.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/ngx/balancer.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/ngx/balancer.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/ngx/ocsp.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/ngx/ocsp.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/ngx/semaphore.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/ngx/semaphore.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/ngx/ssl.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/ngx/ssl.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/request.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/request.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/base64.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/resty/core/base64.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/base.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/resty/core/base.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/ctx.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/resty/core/ctx.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/exit.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/resty/core/exit.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/hash.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/resty/core/hash.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/resty/core.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/misc.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/resty/core/misc.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/regex.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/resty/core/regex.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/request.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/resty/core/request.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/response.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/resty/core/response.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/shdict.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/resty/core/shdict.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/time.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/resty/core/time.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/uri.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/resty/core/uri.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/var.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/resty/core/var.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/core/worker.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/resty/core/worker.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/http_headers.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/resty/http_headers.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/resty/http.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/resty/http.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/socket.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/socket.lua"),
    }
    file {"/usr/local/nginx/conf/lualib/var.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lualib/var.lua"),
    }
    file {"/usr/local/nginx/conf/lua/limit_test.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua/limit_test.lua"),
    }
    file {"/usr/local/nginx/conf/lua/local_ips.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua/local_ips.lua"),
    }
    file {"/usr/local/nginx/conf/lua_phase/mod_bw3_dwstatic_com.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua_phase/mod_bw3_dwstatic_com.lua"),
    }
    file {"/usr/local/nginx/conf/lua_phase/mod_f3tm_f3key.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua_phase/mod_f3tm_f3key.lua"),
    }
    file {"/usr/local/nginx/conf/lua_phase/mod_lecloudoverseaswx_icntvcdn_com.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua_phase/mod_lecloudoverseaswx_icntvcdn_com.lua"),
    }
    file {"/usr/local/nginx/conf/lua_phase/mod_musiccdn_duohappy_cn.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua_phase/mod_musiccdn_duohappy_cn.lua"),
    }
    file {"/usr/local/nginx/conf/lua_phase/mod_ottvideoyd_hifuntv_com.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua_phase/mod_ottvideoyd_hifuntv_com.lua"),
    }
    file {"/usr/local/nginx/conf/lua_phase/mod_str_oversea001_icntvcdn_com.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua_phase/mod_str_oversea001_icntvcdn_com.lua"),
    }
    file {"/usr/local/nginx/conf/lua_phase/mod_test13_checknetwork_yy_com.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua_phase/mod_test13_checknetwork_yy_com.lua"),
    }
    file {"/usr/local/nginx/conf/lua_phase/mod_v10_pstatp_com.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua_phase/mod_v10_pstatp_com.lua"),
    }
    file {"/usr/local/nginx/conf/lua_phase/mod_wxyx_lszb_atianqi_com.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua_phase/mod_wxyx_lszb_atianqi_com.lua"),
    }
    file {"/usr/local/nginx/conf/lua/post_metadata_process.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua/post_metadata_process.lua"),
    }
    file {"/usr/local/nginx/conf/lua/post_moov_process.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua/post_moov_process.lua"),
    }
    file {"/usr/local/nginx/conf/lua/pre_metadata_process.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua/pre_metadata_process.lua"),
    }
    file {"/usr/local/nginx/conf/lua/pre_moov_process.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua/pre_moov_process.lua"),
    }
    file {"/usr/local/nginx/conf/lua/rtmp_connection.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua/rtmp_connection.lua"),
    }
    file {"/usr/local/nginx/conf/lua/snmpband.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua/snmpband.lua"),
    }
    file {"/usr/local/nginx/conf/lua/spost_moov_process.lua":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/lua/spost_moov_process.lua"),
    }
    file {"/usr/local/nginx/conf/mime.types":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/mime.types"),
    }
    file {"/usr/local/nginx/conf/nginx.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/nginx.conf"),
    }
    file {"/usr/local/nginx/conf/scgi_params":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/scgi_params"),
    }
    file {"/usr/local/nginx/conf/uwsgi_params":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/uwsgi_params"),
    }
    file {"/usr/local/nginx/conf/vhosts/imgo.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/imgo.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/meipai.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/meipai.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/miaopai.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/miaopai.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_adown_myaora_net_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_adown_myaora_net_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_a_ext_download_cdnbtst_lecloud_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_a_ext_download_cdnbtst_lecloud_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_a_ext_vod_cdnbtst_lecloud_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_a_ext_vod_cdnbtst_lecloud_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_apk3_cdn_anzhi_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_apk3_cdn_anzhi_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_appdown_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_appdown_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_appstore-dl_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_appstore-dl_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_beta_unity3d_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_beta_unity3d_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_bw3_dwstatic_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_bw3_dwstatic_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cdn2_msg_tcloudfamily_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_cdn2_msg_tcloudfamily_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cdn5_lizhi_fm_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_cdn5_lizhi_fm_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cdnb_file_test_lecloud_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_cdnb_file_test_lecloud_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cdnb-newarch_test_lecloud_com.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_cdnb-newarch_test_lecloud_com.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cdn_enhancecms_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_cdn_enhancecms_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cdn_lecdn_huluxia_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_cdn_lecdn_huluxia_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cdn_lecloud_vcinema_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_cdn_lecloud_vcinema_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cdnleshi_miloli_info_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_cdnleshi_miloli_info_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cdn_myaora_net_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_cdn_myaora_net_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cdn_tvhuan_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_cdn_tvhuan_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_cmmap_careland_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_cmmap_careland_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_d2_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_d2_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_d_app_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_d_app_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_d_appstoreh_atianqi_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_d_appstoreh_atianqi_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_d_appstore_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_d_appstore_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_d_app_tcl_hifuntv_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_d_app_tcl_hifuntv_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_dazenota_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_dazenota_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_d_chapp_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_d_chapp_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_default.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_default.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_dl_ch_hifuntv_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_dl_ch_hifuntv_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_dl_lsy_tclclouds_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_dl_lsy_tclclouds_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_dl_xyaz_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_dl_xyaz_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down10b_zol_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_down10b_zol_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down10c_zol_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_down10c_zol_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down10_zol_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_down10_zol_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down11t_zol_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_down11t_zol_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down3_weapp_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_down3_weapp_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down8b_zol_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_down8b_zol_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down8_zol_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_down8_zol_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down9b_zol_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_down9b_zol_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down9_zol_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_down9_zol_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_download1_healthmall_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_download1_healthmall_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_download2_ys7_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_download2_ys7_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_download_careland_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_download_careland_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_download_changhong_upgrade2_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_download_changhong_upgrade2_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_download_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_download_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_downloadf_dewmobile_net_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_downloadf_dewmobile_net_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_download-letv_golivetv_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_download-letv_golivetv_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down_sarrs_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_down_sarrs_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_down_weapp_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_down_weapp_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_d_tclapp_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_d_tclapp_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_dv_spriteapp_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_dv_spriteapp_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_gameload_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_gameload_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_gdown_baidu_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_gdown_baidu_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_gg-m3u81_gole_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_gg-m3u81_gole_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_gg-m3u82_gole_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_gg-m3u82_gole_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_gg-test_goscreen_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_gg-test_goscreen_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_gongkao_download_duia_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_gongkao_download_duia_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_gvideo_le_my7v_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_gvideo_le_my7v_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_haocdnle_trafficmanager_cn.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_haocdnle_trafficmanager_cn.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_huan_mediacdn_cedock_net_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_huan_mediacdn_cedock_net_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_im_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_im_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_img01_xgmimg_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_img01_xgmimg_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_img2_cedock_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_img2_cedock_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_img_ads_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_img_ads_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_ivviota_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_ivviota_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_jiulian_odm_update_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_jiulian_odm_update_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k10_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_k10_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k12_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_k12_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k1_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_k1_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k245_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_k245_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k2_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_k2_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k3_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_k3_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k4_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_k4_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k5_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_k5_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k6_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_k6_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k8_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_k8_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_k9_audiocn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_k9_audiocn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_kan2_video_anyan_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_kan2_video_anyan_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_le-apk_wdjcdn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_le-apk_wdjcdn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_lecloudcdn_myccdn_info_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_lecloudcdn_myccdn_info_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_lecloud_daxiangjia_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_lecloud_daxiangjia_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_lecloud_educdn_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_lecloud_educdn_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_lecloud_gamezonecdn_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_lecloud_gamezonecdn_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_lecloudoverseaswx_icntvcdn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_lecloudoverseaswx_icntvcdn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_ledownload_crimoon_net_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_ledownload_crimoon_net_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_le_game_oacg_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_le_game_oacg_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_leod_qingting_fm_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_leod_qingting_fm_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_les_waqu_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_les_waqu_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_letvblive_tvfan_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_letvblive_tvfan_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_letv_cdntest_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_letv_cdntest_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_letv_v_tvxio_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_letv_v_tvxio_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_le_v2_xiaoying_tv.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_le_v2_xiaoying_tv.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_ls_hls_ott_cibntv_net_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_ls_hls_ott_cibntv_net_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_lsm3u8_snctv_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_lsm3u8_snctv_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_m3u81_gole_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_m3u81_gole_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_m3u82_gole_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_m3u82_gole_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_m3u8-tw1_gole_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_m3u8-tw1_gole_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_m3u8-tw2_gole_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_m3u8-tw2_gole_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_mccdntest-samsung-letv_trafficmanager_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_mccdntest-samsung-letv_trafficmanager_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_media_ourteacher_com_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_media_ourteacher_com_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_meipai.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_meipai.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_ms_wifienjoy_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_ms_wifienjoy_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_musiccdn_duohappy_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_musiccdn_duohappy_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_ne-letv_v_tvxio_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_ne-letv_v_tvxio_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_newcdntest_cdnle_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_newcdntest_cdnle_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_ota_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_ota_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_otadownload_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_otadownload_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_otatest_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_otatest_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_ottvideoyd_hifuntv_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_ottvideoyd_hifuntv_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_ott_yunduan_cust_cdnbtst_lecloud_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_ott_yunduan_cust_cdnbtst_lecloud_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_pcdownyd_titan_mgtv_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_pcdownyd_titan_mgtv_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_pcvideoyd_titan_mgtv_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_pcvideoyd_titan_mgtv_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_resource_wifienjoy_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_resource_wifienjoy_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_res_zhuanzhuan888_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_res_zhuanzhuan888_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_sdown_myaora_net_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_sdown_myaora_net_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_stream1_grtn_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_stream1_grtn_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_str_oversea001_icntvcdn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_str_oversea001_icntvcdn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_sys-update_ch_hifuntv_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_sys-update_ch_hifuntv_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_tcdn_lovegamecenter_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_tcdn_lovegamecenter_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_test001_isurecloud_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_test001_isurecloud_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_test13_checknetwork_yy_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_test13_checknetwork_yy_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_testdownload_coolyun_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_testdownload_coolyun_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_testoppo_lecloud_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_testoppo_lecloud_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_test_yximgs.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_test_yximgs.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_trs-m3u81_gole_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_trs-m3u81_gole_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_tshop-oss_launcher_tcloudfamily_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_tshop-oss_launcher_tcloudfamily_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_tsl6_hls_cutv_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_tsl6_hls_cutv_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_tv12_audiocn_org_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_tv12_audiocn_org_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_tv245_audiocn_org_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_tv245_audiocn_org_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_update302_lejiao_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_update302_lejiao_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_update_cedock_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_update_cedock_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_update_lejiao_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_update_lejiao_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_v10_pstatp_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_v10_pstatp_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_v7a_pstatp_com.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_v7a_pstatp_com.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_vhalltest_cdnle_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_vhalltest_cdnle_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_video19_ifeng_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_video19_ifeng_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_video_carousel_huan_tv_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_video_carousel_huan_tv_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_video_le_my7v_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_video_le_my7v_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_Video_sarrs_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_Video_sarrs_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_vip_80166_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_vip_80166_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_v_lexiaobao_net_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_v_lexiaobao_net_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_vod-lecdn_dian_fm_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_vod-lecdn_dian_fm_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_vod_letvcdn_readtv_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_vod_letvcdn_readtv_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_w3_dwstatic_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_w3_dwstatic_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_wdjcdn_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_wdjcdn_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_wildcard_ext_download_cdnbtst_lecloud_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_wildcard_ext_download_cdnbtst_lecloud_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_wildcard_ext_vod_cdnbtst_lecloud_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_wildcard_ext_vod_cdnbtst_lecloud_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_wting_info_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_wting_info_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_wwd_mediacdn_cedock_net_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_wwd_mediacdn_cedock_net_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_www_microvirt_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_www_microvirt_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_wxyx_lszb_atianqi_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_wxyx_lszb_atianqi_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_xytv_hls_cutv_com_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_xytv_hls_cutv_com_x.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_ys7.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_ys7.conf"),
    }
    file {"/usr/local/nginx/conf/vhosts/server_yunduan_cdn_mojing_cn_x.conf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/vhosts/server_yunduan_cdn_mojing_cn_x.conf"),
    }
    file {"/usr/local/nginx/conf/win-utf":
        ensure => file,
        mode => 644,
        content => template("nginx2_cdn_dev/win-utf"),
    }
    file {"/usr/local/nginx/conf/lualib/socket/core.so":
        ensure => file,
        mode => 644,
        source => "puppet://$fileserver/nginx2_cdn_dev/core.so",
    }
    file {"/usr/local/nginx/conf/lualib/cjson.so":
        ensure => file,
        mode => 644,
        source => "puppet://$fileserver/nginx2_cdn_dev/cjson.so",
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
            File["/usr/local/nginx/conf/cert/ys7_com.key"],
            File["/usr/local/nginx/conf/cert/ys7_com.pem"],
            File["/usr/local/nginx/conf/fastcgi.conf"],
            File["/usr/local/nginx/conf/fastcgi_params"],
            File["/usr/local/nginx/conf/koi-utf"],
            File["/usr/local/nginx/conf/koi-win"],
            File["/usr/local/nginx/conf/lua/dns_secure_link.lua"],
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
            File["/usr/local/nginx/conf/lua/local_ips.lua"],
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
            File["/usr/local/nginx/conf/lua/spost_moov_process.lua"],
            File["/usr/local/nginx/conf/mime.types"],
            File["/usr/local/nginx/conf/nginx.conf"],
            File["/usr/local/nginx/conf/scgi_params"],
            File["/usr/local/nginx/conf/uwsgi_params"],
            File["/usr/local/nginx/conf/vhosts/imgo.conf"],
            File["/usr/local/nginx/conf/vhosts/meipai.conf"],
            File["/usr/local/nginx/conf/vhosts/miaopai.conf"],
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
            File["/usr/local/nginx/conf/vhosts/server_d2_coolyun_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_d_app_huan_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_d_appstoreh_atianqi_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_d_appstore_huan_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_d_app_tcl_hifuntv_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_dazenota_coolyun_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_d_chapp_huan_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_default.conf"],
            File["/usr/local/nginx/conf/vhosts/server_dl_ch_hifuntv_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_dl_lsy_tclclouds_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_dl_xyaz_cn_x.conf"],
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
            File["/usr/local/nginx/conf/vhosts/server_ls_hls_ott_cibntv_net_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_lsm3u8_snctv_com_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_m3u81_gole_tv_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_m3u82_gole_tv_x.conf"],
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
            File["/usr/local/nginx/conf/vhosts/server_resource_wifienjoy_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_res_zhuanzhuan888_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_sdown_myaora_net_x.conf"],
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
            File["/usr/local/nginx/conf/vhosts/server_vod-lecdn_dian_fm_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_vod_letvcdn_readtv_cn_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_w3_dwstatic_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_wdjcdn_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_wildcard_ext_download_cdnbtst_lecloud_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_wildcard_ext_vod_cdnbtst_lecloud_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_wting_info_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_wwd_mediacdn_cedock_net_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_www_microvirt_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_wxyx_lszb_atianqi_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_xytv_hls_cutv_com_x.conf"],
            File["/usr/local/nginx/conf/vhosts/server_ys7.conf"],
            File["/usr/local/nginx/conf/vhosts/server_yunduan_cdn_mojing_cn_x.conf"],
            File["/usr/local/nginx/conf/win-utf"],
            File["/usr/local/nginx/conf/lualib/socket/core.so"],
            File["/usr/local/nginx/conf/lualib/cjson.so"],
        ],
        onlyif => '/usr/local/nginx/sbin/nginx -c /usr/local/nginx/conf/nginx.conf -t',
        refreshonly => true,
    }
}
