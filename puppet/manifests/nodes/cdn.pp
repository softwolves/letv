node servercdn {
  include puppet_all
  include systembase_cdn
  include watchdog_cdn
  include btdaemon_cdn
  include zabbix_all
  include ats_cdn
  include nginx_cdn
  include cagent_cdn
  include rtmp_cdn

  include stresstest_cdn
  include cto2_all
#  include salt_all
  include collector_cdn
  include openresty_cdn
  include xagent_all
  include watchdog2_cdn
  include slice2http_cdn
  include pinger_cdn
  include spider_cdn
  include falcon-agent_all
  }

node servercdntest{
  include puppet_all
  include systembase_cdn_dev
  include watchdog_cdn_dev
  include btdaemon_cdn_dev
  include zabbix_all
  include nginx_cdn_dev
  include ats_cdn_dev
  include cagent_cdn_dev
#  include rtmp_cdn_dev

  include stresstest_cdn
  include cto2_all_dev
#  include salt_all
  include collector_cdn_dev
  include openresty_cdn_dev
  include xagent_all
  include watchdog2_cdn_dev
  include slice2http_cdn_dev
  include pinger_cdn_dev
  include spider_cdn_dev
  include falcon-agent_all
  }


#####第三方配置特殊化
node /^cdn-gd-gz-yyz-cmcc-\d+/ {
  include puppet_all
  include systembase_cdn_spe
  include watchdog_cdn
  include btdaemon_cdn
  include zabbix_all
  include ats_cdn
  include nginx_cdn
  include cagent_cdn
  include rtmp_cdn

  include stresstest_cdn
  include cto2_all
  include collector_cdn
  include openresty_cdn
  include xagent_all
  include watchdog2_cdn
  include pinger_cdn
  include spider_cdn
  include falcon-agent_all
}
##################qa##########
node /^cdn-bj-cnc-\d+/ {
  include puppet_all
  include systembase_cdn_qa
  include watchdog_cdn_qa
  include btdaemon_cdn
  include zabbix_all
  include ats_cdn_qa
  include nginx_cdn_qa
  include cagent_cdn
  include rtmp_cdn_qa

  include stresstest_cdn
  include cto2_all_dev
  include collector_cdn_qa
  include openresty_cdn_qa
  include xagent_all
  include watchdog2_cdn
  include pinger_cdn_dev
  include spider_cdn_dev
  include falcon-agent_all
}
###############cdn-hb-xn-ctc2-###multi connection 测试
node /^cdn-hb-xn-ctc2-\d+/ {
  include puppet_all
  include systembase_cdn_sta
  include watchdog_cdn
  include btdaemon_cdn
  include zabbix_all
  include rtmp_cdn_multi_tmp
  include ats_cdn_sta
  include nginx_cdn
  include cagent_cdn

  include stresstest_cdn
  include cto2_all
#  include salt_all
  include collector_cdn
  include openresty_cdn
  include xagent_all
  include watchdog2_cdn
  include slice2http_cdn
  include pinger_cdn
  include spider_cdn
  include falcon-agent_all
}

node /^cdn-usa-\d+/ {
  include puppet_all
  include systembase_cdn
  include watchdog_cdn
  include btdaemon_cdn
  include zabbix_all
  include rtmp_cdn_usa
  include ats_cdn
  include nginx_cdn
  include cagent_cdn

  include stresstest_cdn
  include cto2_all
#  include salt_all
  include collector_cdn
  include openresty_cdn
  include xagent_all
  include watchdog2_cdn
  include slice2http_cdn
  include pinger_cdn
  include spider_cdn
  include falcon-agent_all
}

node /^cdn-gd-dg-zm-ctc-\d+/ {
  include puppet_all
  include systembase_cdn
  include watchdog_cdn
  include btdaemon_cdn
  include zabbix_all
  include rtmp_cdn_tmp
  include ats_cdn
  include nginx_cdn
  include cagent_cdn

  include stresstest_cdn
  include cto2_all
#  include salt_all
  include collector_cdn
  include openresty_cdn
  include xagent_all
  include watchdog2_cdn
  include slice2http_cdn
  include pinger_cdn
  include spider_cdn
  include falcon-agent_all
}


######################测试节点cdnid=707,name=HLJ-SH-CNC#############
#node /cdn-xkz-ott-cnc-\d+/,/cdn-hb-lf-cnc-79/,/cdn-hlj-sh-cnc-\d+/,/^cdn-hb-hd-cnc-\d+/,/^cdn-sx-bj-ctc-\d+/,/^cdn-sx-bj-ctc2-\d+/,/^cdn-tj-ctc2-\d+/,/cdn-hn-ly-cnc-\d+/,/cdn-sd-jn-cnc3-\d+/,/cdn-tj-bgp-\d+/,/cdn-bj-ctc3-\d+/ inherits servercdntest {

#node /^cdn-hlj-sh-cnc-\d+/,/^cdn-hb-lf-cnc-79/ inherits servercdntest {
node /^cdn-hlj-sh-cnc-\d+/,/^cdn-hb-lf-cnc-79/,/cdn-hb-xt-cnc3-\d+/,/^cdn-hb-hd-cnc-\d+/,/^cdn-sx-bj-ctc-\d+/,/^cdn-hb-lf-ctc-\d+/,/^cdn-tj-ctc3-\d+/,/^cdn-sx-ll-cnc-\d+/,/cdn-sd-jn-cnc4-\d+/ inherits servercdntest {
#node /^cdn-hlj-sh-cnc-\d+/,/cdn-hb-xt-cnc3-\d+/,/cdn-gd-dg-zm-ctc-\d+/ inherits servercdntest {

  include rtmp_cdn_dev
  
}

#node /cdn-hlj-sh-cnc-130/,/^cdn-hlj-sh-cnc-131/,/^cdn-hlj-sh-cnc-132/,/^cdn-hlj-sh-cnc-133/,/^cdn-hlj-sh-cnc-134/,/^cdn-hlj-sh-cnc-135/,/^cdn-hlj-sh-cnc-136/,/^cdn-hlj-sh-cnc-137/,/^cdn-hlj-sh-cnc-138/,/^cdn-hlj-sh-cnc-139/,/^cdn-hb-hd-cnc-2/,/^cdn-hb-hd-cnc-3/,/^cdn-hb-hd-cnc-4/,/^cdn-hb-hd-cnc-5/,/^cdn-hb-hd-cnc-6/,/^cdn-sx-bj-ctc-130/,/^cdn-sx-bj-ctc-131/,/^cdn-sx-bj-ctc-132/,/^cdn-sx-bj-ctc-133/,/^cdn-sx-bj-ctc-134/,/^cdn-sx-bj-ctc-135/,/^cdn-sx-bj-ctc-136/,/^cdn-sx-bj-ctc-137/,/^cdn-sx-bj-ctc-138/,/^cdn-sx-bj-ctc-139/,/^cdn-sx-bj-ctc2-130/,/^cdn-sx-bj-ctc2-131/,/^cdn-sx-bj-ctc2-132/,/^cdn-sx-bj-ctc2-133/,/^cdn-sx-bj-ctc2-134/,/^cdn-sx-bj-ctc2-135/,/^cdn-sx-bj-ctc2-136/,/^cdn-sx-bj-ctc2-137/,/^cdn-sx-bj-ctc2-138/,/^cdn-sx-bj-ctc2-139/,/^cdn-tj-ctc2-32/,/^cdn-tj-ctc2-33/,/^cdn-tj-ctc2-34/,/^cdn-tj-ctc2-35/,/^cdn-tj-ctc2-36/,/^cdn-tj-ctc2-37/,/^cdn-tj-ctc2-38/,/^cdn-tj-ctc2-39/,/^cdn-tj-ctc2-40/,/^cdn-tj-ctc2-41/,/^cdn-tj-ctc2-42/,/^cdn-tj-ctc2-43/,/^cdn-tj-ctc2-44/,/^cdn-tj-ctc2-45/,/^cdn-tj-ctc2-46/ inherits servercdntest {
#  include rtmp_cdn_dev
#}

#node /cdn-hn-ly-cnc-\d+/,/cdn-sd-jn-cnc3-\d+/,/cdn-tj-bgp-\d+/,/cdn-bj-ctc3-\d+/{
#  include puppet_all
#  include systembase_cdn
#  include watchdog_cdn
#  include zabbix_all
#  include nginx_cdn
#  include ats_cdn
#  include cagent_cdn
#  include rtmp_cdn_dev

#  include stresstest_cdn
#  include cto2_all
#  include salt_all
#}
#
#node cdn-hlj-sh-cnc-136 inherits servercdn {
#
#  include nginx_cdn
#  }


#node /^cdn-ah-hf-cnc-\d+/,/^cdn-bj-anw-cnc-\d+/,/^cdn-bj-cnc-\d+/,/^cdn-cq-cnc2-\d+/,/^cdn-cq-cnc3-\d+/,/^cdn-cq-cnc4-\d+/,/^cdn-cq-cnc5-\d+/,/^cdn-cq-wanz-cnc-\d+/,/^cdn-fj-fz2-ott-cnc-\d+/,/^cdn-fj-fz-cnc-\d+/,/^cdn-fj-ly-cnc-\d+/,/^cdn-fj-qz-cnc-\d+/,/^cdn-fj-sm-cnc-\d+/,/^cdn-fj-xm-cnc-\d+/,/^cdn-fj-zz-cnc-\d+/,/^cdn-gd-zj-cnc-\d+/,/^cdn-gx-bh-cnc-\d+/,/^cdn-gx-bs-cnc-\d+/,/^cdn-gx-cz-cnc-\d+/,/^cdn-gx-fcg-cnc-\d+/,/^cdn-gx-gg-cnc-\d+/,/^cdn-gx-gl-cnc-\d+/,/^cdn-gx-hc-cnc-\d+/,/^cdn-gx-hz-cnc-\d+/,/^cdn-gx-lb-cnc-\d+/,/^cdn-gx-lz-cnc-\d+/,/^cdn-gx-nn-cnc-\d+/,/^cdn-gx-qz-cnc-\d+/,/^cdn-gx-wz-cnc-\d+/,/^cdn-gx-yl-cnc-\d+/,/^cdn-gz-gy-cnc-\d+/,/^cdn-gz-lps-cnc-\d+/,/^cdn-gz-qn-cnc-\d+/,/^cdn-hain-hk-cnc-\d+/,/^cdn-hb-hd-cnc2-\d+/,/^cdn-hb-jm-cnc-\d+/,/^cdn-hb-sjz-cnc-\d+/,/^cdn-hb-sjz-cnc3-\d+/,/^cdn-hb-ts-cnc-\d+/,/^cdn-hb-wh-cnc-\d+/,/^cdn-hb-wh-cnc2-\d+/,/^cdn-hb-xt-cnc-\d+/,/^cdn-hb-xt-cnc2-\d+/,/^cdn-hb-xy-cnc-\d+/,/^cdn-hb-yc-cnc-\d+/,/^cdn-hb-zz-cnc-\d+/,/^cdn-hebei-sjz1-cnc-\d+/,/^cdn-hebei-sjz2-cnc-\d+/,/^cdn-hlj-heb-cnc2-\d+/,/^cdn-hlj-sh-cnc2-\d+/,/^cdn-hlj-sys-cnc-\d+/,/^cdn-hn-cs-cnc-\d+/,/^cdn-hn-ly2-cnc-\d+/,/^cdn-hn-ly3-cnc-\d+/,/^cdn-hn-py-cnc-\d+/,/^cdn-hn-xc-cnc-\d+/,/^cdn-hn-zz-cnc-\d+/,/^cdn-jl-bc-cnc-\d+/,/^cdn-jl-cc-cnc-4-\d+/,/^cdn-jl-sp-cnc-\d+/,/^cdn-jl-yb-cnc-\d+/,/^cdn-js-nj-cnc-\d+/,/^cdn-js-xz-cnc-\d+/,/^cdn-js-yz-cnc-\d+/,/^cdn-jx-nc-cnc-\d+/,/^cdn-ln-dl-cnc-\d+/,/^cdn-ln-fs-cnc-\d+/,/^cdn-ln-pj-cnc-\d+/,/^cdn-nmg-wh-cnc-\d+/,/^cdn-qh-xn-cnc-\d+/,/^cdn-sc-bz-cnc-\d+/,/^cdn-sc-cd-cnc-\d+/,/^cdn-sc-dy-cnc-\d+/,/^cdn-sc-dz-cnc-\d+/,/^cdn-sc-gan-cnc-\d+/,/^cdn-sc-guangy-cnc-143-\d+/,/^cdn-sc-guangy-cnc-45-\d+/,/^cdn-sc-ls-cnc-\d+/,/^cdn-sc-lz-cnc-\d+/,/^cdn-sc-ms-cnc-\d+/,/^cdn-sc-my-cnc-49-\d+/,/^cdn-sc-my-cnc-88-\d+/,/^cdn-sc-nc-cnc-\d+/,/^cdn-sc-nj-cnc-\d+/,/^cdn-sc-pzh-cnc-\d+/,/^cdn-sc-sn-cnc-\d+/,/^cdn-sc-xic-cnc-\d+/,/^cdn-sc-yaan-cnc-\d+/,/^cdn-sc-yb-cnc-\d+/,/^cdn-sc-zg-cnc-\d+/,/^cdn-sc-zy-cnc-\d+/,/^cdn-sd-dz-cnc-\d+/,/^cdn-sd-hz-cnc-\d+/,/^cdn-sd-jn1-cnc-\d+/,/^cdn-sd-jn2-cnc-\d+/,/^cdn-sd-lc-cnc-\d+/,/^cdn-sd-lc-cnc2-\d+/,/^cdn-sd-qd-cnc-\d+/,/^cdn-sd-qd-cnc2-\d+/,/^cdn-sd-qd-cnc3-\d+/,/^cdn-sd-wf-cnc-\d+/,/^cdn-sd-wh-cnc-\d+/,/^cdn-sd-yt-cnc-\d+/,/^cdn-sd-zz-cnc-\d+/,/^cdn-sh2-cnc-\d+/,/^cdn-sh-cnc-\d+/,/^cdn-sx-cz-cnc-\d+/,/^cdn-sx-lf-cnc-\d+/,/^cdn-sx-ty1-cnc-\d+/,/^cdn-sx-ty2-cnc-\d+/,/^cdn-sx-ty-cnc-\d+/,/^cdn-sx-xan-cnc-\d+/,/^cdn-xj-bz-cnc-\d+/,/^cdn-xj-kt-cnc-\d+/,/^cdn-xj-wlmq-cnc-\d+/,/^cdn-xz-ls-cnc-\d+/,/^cdn-yn-ann-cnc-\d+/,/^cdn-yn-km-cnc-\d+/,/^cdn-yn-qj-cnc-\d+/,/^cdn-yn-zt-cnc-\d+/,/^cdn-zj-jx-cnc-\d+/,/^cdn-zj-ls-ctc-\d+/,/^cdn-zj-wz-cnc-\d+/,/^cdn-zj-zs-cnc-\d+/ inherits servercdn {
#  include cto2_all
#  include nginx_cdn
#  include systembase_cdn
#}



######################用于黑洞机房 
#node /cdn-hb-bd-cnc-\d+/,/cdn-zj-jiax-ctc-\d+/{
#node /cdn-zj-jiax-ctc-\d+/{
#cdnid=898,cdnid=752
node /^cdn-ln-pj-cnc2-\d+/,/^cdn-zj-cx-ctc-\d+/{
  include puppet_all
  include systembase_cdn
  include watchdog_cdn
  include btdaemon_cdn
  include zabbix_all
  include ats_cdn
  include nginx_cdn_heidong
  include cagent_cdn
  include rtmp_cdn

  include stresstest_cdn
  include cto2_all
#  include salt_all
  include openresty_cdn
  include xagent_all
  include watchdog2_cdn
  include pinger_cdn
  include spider_cdn
  include falcon-agent_all
}
#
#
#
#####################cdn CNC###########

#node /^cdn.*-cnc.*\d+$/ inherits servercdn {
#  include nginx_cdn
#  include systembase_cdn_dev
#  }


#node /^cdn.*-cnc.*\d+$/ {
#  include puppet_all
#  include systembase_cdn
#  include watchdog_cdn
#  include zabbix_all
#  include ats_cdn
#  include nginx_cdn_dev
#  include cagent_cdn
#  include rtmp_cdn

#  include stresstest_cdn
#  include cto2_all
#  include salt_all
#  include collector_cdn
#  include openresty_cdn
#}
#

#node /^cdn.*-cnc.*\d+$/,/cdn-bj-ctc-\d+/,/cdn-bj-jan-ctcy-\d+/,/cdn-bj-jxq-ctcy-\d+/,/cdn-cq-ctc-\d+/,/cdn-fj-fz-ctc-\d+/,/cdn-gd-dg-ctc-\d+/,/cdn-gd-fs-ctc-\d+/,/cdn-gd-gz-ctc-\d+/,/cdn-gd-gz-ctcy-\d+/,/cdn-gd-mm-ctc-\d+/,/cdn-gd-st-ctc-\d+/,/cdn-gd-sz-ctcy-\d+/,/cdn-gd-zs-ctc-\d+/,/cdn-gs-lz-ctc-\d+/,/cdn-gx-nn-ctc-\d+/,/cdn-gz-xy-ctc-\d+/,/cdn-hb-wh-ctc-\d+/,/cdn-hb-xn-ctc-\d+/,/cdn-hlj-heb-ctc-\d+/,/cdn-hn-cs-ctc-\d+/,/cdn-hn-hk-ctc-\d+/,/cdn-hn-sy-ctc-\d+/,/cdn-js-nj-ctc-\d+/,/cdn-js-nt-ctc-\d+/,/cdn-js-wx-ctc-\d+/,/cdn-js-yz-ctc-\d+/,/cdn-jx-nc-ctc-\d+/,/cdn-ln-dl-ctc-\d+/,/cdn-nm-hhht-ctc-\d+/,/cdn-sc-cd-ctc-\d+/,/cdn-sd-qd-ctc-\d+/,/cdn-sh-ctc-\d+/,/cdn-sh-suf-ctc-\d+/,/cdn-sx-ty-ctc-\d+/,/cdn-sx-xan-ctc-\d+/,/cdn-tj-ctc-\d+/,/cdn-yn-chux-ctc-\d+/,/cdn-zj-ls-ctc-\d+/,/cdn-zj-nb-ctc-\d+/,/cdn-zj-wz-ctc-\d+/,/cdn-zj-wz-ctc-rad-\d+/,/cdn-zj-wz-ctcy-\d+/ {
#node /^cdn.*-cnc.*\d+$/ {
#  include puppet_all
#  include systembase_cdn
#  include watchdog_cdn
#  include btdaemon_cdn
#  include zabbix_all
#  include ats_cdn
#  include nginx_cdn_dev
#  include cagent_cdn
#  include rtmp_cdn

#  include stresstest_cdn
#  include cto2_all
#  include salt_all
#  include collector_cdn
#  include openresty_cdn
#  include xagent_all
#  include watchdog2_cdn
#  include slice2http_cdn
#}
######所有cdn服务器##########
#node /^newcdn-haiwai-italy-milan-\d+/,/^newcdn-hk-heji-\d+/,/^newcdn-bj-fzkd-\d+/,/^newcdn-bj-hd-edu2-\d+/,/^newcdn-gd-gz-edu-\d+/,/^newcdn-hb-wh-edu-\d+/,/^newcdn-hn-zz-edu-\d+/,/^newcdn-zj-hz-wasu3-\d+/,/^newcdn-gz-gy-ctc-\d+/,/^newcdn-hn-ly-ctc2-\d+/,/^newcdn-hn-zz-ctc-\d+/,/^newcdn-jl-cc-ctc-\d+/,/^newcdn-js-zjg-ctc-\d+/,/^newcdn-nmg-hhht-ctc2-\d+/,/^newcdn-ah-cz-ctc-\d+/,/^newcdn-hn-cs-ctc2-\d+/,/^newcdn-js-sz-ctc-\d+/,/^newcdn-jx-yt-ctc-\d+/,/^newcdn-sc-gy-ctc-\d+/,/^newcdn-sx-xy-ctc2-\d+/,/^newcdn-zj-tz-ctc-\d+/,/^newcdn-gd-dg-ctc5-\d+/,/^newcdn-gd-hz-ctc2-\d+/,/^newcdn-jx-ja-ctc-\d+/,/^newcdn-sc-dy-ctc-\d+/,/^newcdn-sd-ly-cnc-\d+/,/^newcdn-sx-xa-ctc3-\d+/,/^newcdn-zj-la-ctc-\d+/,/^newcdn-hb-hd-cnc3-\d+/,/^newcdn-hb-xn-ctc-\d+/,/^newcdn-hn-xc-ctc-\d+/,/^newcdn-jn-cc-cnc4-\d+/,/^newcdn-jx-nc-ctc-\d+/,/^newcdn-sd-qd-ctc2-\d+/,/^newcdn-tj-cnc-\d+/,/^newcdn-zj-wz-cnc2-\d+/,/^newcdn-fj-fz-ctc2-\d+/,/^newcdn-gd-fs-cnc-\d+/,/^newcdn-gd-fs-sd-ctc-\d+/,/^newcdn-hb-sjz-cnc4-\d+/,/^newcdn-js-ha-ctc-\d+/,/^newcdn-ln-sy-cnc3-\d+/,/^newcdn-newcdn-cq-cnc-\d+/,/^newcdn-nmg-hhht-cnc2-\d+/,/^newcdn-sd-jn-ctc2-\d+/,/^newcdn-sx-jz-cnc2-\d+/,/^newcdn-tj-dg-ctc3-\d+/,/^newcdn-zj-nb-ctc3-\d+/,/^newcdn-tj-nk-ctc-\d+/,/^newcdn-bj-sjs-cnc-\d+/,/^newcdn-gz-qxnz-xy-ctc-\d+/,/^newcdn-hn-hy-ctc-\d+/,/^newcdn-hn-ly-cnc5-\d+/,/^newcdn-ln-dl-cnc2-\d+/,/^newcdn-ln-sy-ctc-\d+/,/^newcdn-sx-ty-ctc2-\d+/,/^newcdn-sd-yt-cnc2-\d+/,/^newcdn-hb-qhd-ctc-\d+/,/^newcdn-hb-ts-cnc2-\d+/,/^newcdn-sc-nc-ctc2-\d+/,/^newcdn-sx-dt-cnc-\d+/,/^newcdn-cq-cnc5-\d+/,/^newcdn-hn-kf-cnc-\d+/,/^newcdn-nmg-hhht-cnc-\d+/,/^newcdn-sd-jn-cnc5-\d+/,/^newcdn-sx-lf-cnc2-\d+/,/^newcdn-hn-hy-cnc-\d+/,/^newcdn-gx-nn-ctc4-\d+/,/^newcdn-fj-pt-ctc3-\d+/,/^newcdn-tj-gwbn3-\d+/,/^newcdn-hn-zz-cmcc2-\d+/,/^newcdn-qh-xn-cmcc-\d+/,/^newcdn-nx-yc-cmcc-\d+/,/^newcdn-hb-xy-cmcc2-\d+/,/^newcdn-sd-jn-cnc4-\d+/,/^newcdn-gd-gz-cmcc-\d+/,/^newcdn-jl-cc-cmcc3-\d+/,/^newcdn-js-sz-cmcc-\d+/,/^newcdn-jx-nc-cmcc6-\d+/,/^newcdn-gd-fs-gwbn2-\d+/,/^newcdn-haiwai-aus-mel-\d+/,/^newcdn-hb-wh-gwbn4-\d+/,/^newcdn-haiwai-usa-atlan-\d+/,/^newcdn-hlj-heb-cmcc-\d+/,/^newcdn-yn-km-cmcc-\d+/,/^newcdn-tj-nk-cmcc-\d+/,/^newcdn-zj-wz-ctc4-\d+/,/^newcdn-sd-qd-cmcc-\d+/,/^newcdn-hn-ly-cmcc-\d+/,/^newcdn-sc-cd-cmcc2-\d+/,/^newcdn-gd-dg-cnc-\d+/,/^newcdn-sx-xy-cnc-\d+/,/^newcdn-hb-sjz-cmcc-\d+/,/^newcdn-xj-wlmq-ctc-\d+/,/^newcdn-js-wx-cmcc-\d+/,/^newcdn-haiwai-usa-den-\d+/,/^newcdn-haiwai-usa-sea-\d+/,/^newcdn-haiwai-ina-jkt-\d+/,/^newcdn-hn-ly-cnc6-\d+/,/^newcdn-haiwai-usa-stlouis-\d+/,/^newcdn-haiwai-usa-hui-\d+/,/^newcdn-haiwai-usa-chi-\d+/,/^newcdn-haiwai-usa-phoenix-\d+/,/^newcdn-haiwai-usa-phil-\d+/,/^newcdn-haiwai-usa-boston-\d+/,/^newcdn-haiwai-usa-charlotte-\d+/,/^newcdn-italy-roma-\d+/,/^newcdn-jx-fz-ctc-\d+/ {
#  include zabbix_all
#  include puppet_all
#  include nginx2_cdn
#  include ats5_cdn_dev
#  include systembase_newcdn
#  include watchdog_cdn
#  include btdaemon_cdn
#  include cagent_cdn
#  include rtmp_cdn
#
#  include stresstest_cdn
#  include cto2_all
#  include collector_cdn
#  include openresty_cdn
#  include xagent_all
#  include watchdog2_newcdn
#  include slice2http_cdn
#  include pinger_cdn
#  include spider_cdn
#}

node /^newcdn-hlj-qth-cnc-\d+/,/^newcdn-fj-fz-ctc2-\d+/,/^newcdn-nmg-hhht-cnc3-\d+/,/^newcdn-yn-km-ctc4-\d+/ {
#node /^newcdn-gd-.*/,/^newcdn-tj-.*/,/^newcdn-hn-.*/,/^newcdn-fj-.*/,/^newcdn-sc-.*/,/^newcdn-sh-ctc-\d+/,/^newcdn-zj-wz-cnc2-\d+/,/^newcdn-hb-qhd-ctc-\d+/,/^newcdn-gd-fs-sd-ctc-\d+/,/^newcdn-sc-nc-ctc2-\d+/ {
  include zabbix_all
  include puppet_all
  include nginx2_cdn_dev
  include ats5_cdn_dev
  include systembase_newcdn_dev
  include watchdog_cdn
  include btdaemon_cdn
  include cagent_cdn
  include rtmp_cdn

  include stresstest_cdn
  include cto2_all
  include collector_cdn
  include openresty_cdn
  include xagent_all
  include watchdog2_newcdn_dev
  include slice2http_cdn
  include pinger_cdn_dev
  include spider_cdn_dev
  include falcon-agent_all
}

node /^newcdn-.*/ {
  include zabbix_all
  include puppet_all
  include nginx2_cdn
  include ats5_cdn
  include systembase_newcdn
  include watchdog_cdn
  include btdaemon_cdn
  include cagent_cdn
  include rtmp_cdn

  include stresstest_cdn
  include cto2_all
  include collector_cdn
  include openresty_cdn
  include xagent_all
  include watchdog2_newcdn
  include slice2http_cdn
  include pinger_cdn
  include spider_cdn
  include falcon-agent_all
}

node /^cdn-hk-hkbn-\d+/,/^cdn-hk-kp-\d+/,/^cdn-hk-heji-\d+/,/^cdn-hk-ntt-\d+/,/^cdn-hk-pccw1-\d+/,/^cdn-hk-pccw-\d+/,/^cdn-hk-tko-hkbn-\d+/ {
  include puppet_all
  include systembase_cdn_qa
  include watchdog_cdn
  include btdaemon_cdn
  include zabbix_all
  include rtmp_cdn
  include ats_cdn_qa
  include nginx_cdn
  include cagent_cdn

  include stresstest_cdn
  include cto2_all
#  include salt_all
  include collector_cdn
  include openresty_cdn
  include xagent_all
  include watchdog2_cdn
  include slice2http_cdn
  include pinger_cdn
  include spider_cdn
  include falcon-agent_all
}


########ats
node /^cdn-hn-.*/,/^cdn-gx-.*/,/^cdn-hlj-.*/,/^cdn-sx-.*/,/^cdn-jx-.*/,/^cdn-ah-.*/,/^cdn-sc-.*/,/^cdn-xj-.*/,/^cdn-hb-.*/,/^cdn-hebei-.*/{
  include puppet_all
  include systembase_cdn_sta
  include watchdog_cdn
  include btdaemon_cdn
  include zabbix_all
  include rtmp_cdn
  include ats_cdn_sta
  include nginx_cdn
  include cagent_cdn

  include stresstest_cdn
  include cto2_all
#  include salt_all
  include collector_cdn
  include openresty_cdn
  include xagent_all
  include watchdog2_cdn
  include slice2http_cdn
  include pinger_cdn
  include spider_cdn
  include falcon-agent_all
}
########ats

#######################
node /cdn-.*/ {
  include puppet_all
  include systembase_cdn
  include watchdog_cdn
  include btdaemon_cdn
  include zabbix_all
  include rtmp_cdn
  include ats_cdn
  include nginx_cdn
  include cagent_cdn

  include stresstest_cdn
  include cto2_all
#  include salt_all
  include collector_cdn
  include openresty_cdn
  include xagent_all
  include watchdog2_cdn
  include slice2http_cdn
  include pinger_cdn
  include spider_cdn
  include falcon-agent_all
}
