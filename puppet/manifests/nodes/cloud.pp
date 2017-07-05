node servercloud {
  include puppet_all
  include zabbix_all

  include cto2_all
  include xagent_all
#  include salt_all
  }

node /^cloud-hb-lf-cnc-72/,/^cloud-zj-nb-ctc3-\d+/,/cloud-hn-ly-cnc6-\d+/ inherits servercloud {
#node /cloud-gd-fs-cnc-\d+/,/cloud-ln-sy-ctc-\d+/,/cloud-jx-fz-ctc-\d+/,/cloud-hn-ly-cnc6-\d+/,/cloud-jx-yt-ctc-\d+/,/cloud-zj-wz-ctc4-\d+/ inherits servercloud {
  include systembase_cloud_dev
  include stresstest_cloud
  include watchdog_cloud_dev
  include btdaemon_cloud_dev
  include nginx_cloud_dev
  include cagent_cloud_dev
  include ats_cloud_dev
  include watchdog2_cloud_dev
  include pinger_cdn_dev
  include spider_cdn_dev
  include falcon-agent_all
  }

node /^cloud-.*/ inherits servercloud {
  include systembase_cloud
  include stresstest_cloud
  include watchdog_cloud
  include btdaemon_cloud
  include nginx_cloud
  include cagent_cloud
  include ats_cloud
  include watchdog2_cloud
  include pinger_cdn
  include spider_cdn
  include falcon-agent_all
  }
