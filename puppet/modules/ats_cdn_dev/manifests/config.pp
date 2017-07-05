####nginx config file###
class ats_cdn_dev::config {
#   file{"/etc/trafficserver/snapshots":
#      ensure  =>  directory,
#      mode    =>  755,
#      owner   =>  'ats',
#      group   =>  'ats',
#   }
#
#   file{"/etc/trafficserver/plugin":
#      ensure  =>  directory,
#      mode    =>  755,
#      owner   =>  'ats',
#      group   =>  'ats',
#   }

   file{"/usr/local/letv/ats/":
      ensure  =>  directory,
      mode    =>  755,
      owner   =>  'ats',
      group   =>  'ats',
   }

#   file{"/etc/trafficserver/cache.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/cache.config"),
#   }

#   file{"/etc/trafficserver/cluster.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/cluster.config"),
#   }
#
#   file{"/etc/trafficserver/congestion.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/congestion.config"),
#   }
#
#   file{"/etc/trafficserver/hosting.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/hosting.config"),
#   }
#
#   file{"/etc/trafficserver/icp.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/icp.config"),
#   }
#
#   file{"/etc/trafficserver/ip_allow.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/ip_allow.config"),
#   }
#
#   file{"/etc/trafficserver/log_hosts.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/log_hosts.config"),
#   }
#
#   file{"/etc/trafficserver/logs_xml.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/logs_xml.config"),
#   }
#
#   file{"/etc/trafficserver/parent.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/parent.config"),
#   }

#   file{"/etc/trafficserver/plugin.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/plugin.config"),
#   }

#   file{"/etc/trafficserver/prefetch.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/prefetch.config"),
#   }

#   file{"/etc/trafficserver/proxy.pac":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/proxy.pac"),
#   }
#
#   file{"/etc/trafficserver/records.config_tmp":
#      ensure  =>  file,
#      mode    =>  600,
#      content => template("ats_cdn_dev/records.config"),
#      require =>  File['/etc/trafficserver/records.config.sh'],
#   }
#
#   file{"/etc/trafficserver/records.config.sh":
#      ensure  =>  file,
#      mode    =>  755,
#      content => template("ats_cdn_dev/records.config.sh"),
#   }

#   file{"/etc/trafficserver/remap.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/remap.config"),
#   }

#   file{"/etc/trafficserver/socks.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/socks.config"),
#   }
#
#   file{"/etc/trafficserver/splitdns.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/splitdns.config"),
#   }
#
#   file{"/etc/trafficserver/ssl_multicert.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/ssl_multicert.config"),
#   }
#
#   file{"/etc/trafficserver/stats.config.xml":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/stats.config.xml"),
#   }
#
#   file{"/etc/trafficserver/update.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/update.config"),
#   }
#
#   file{"/etc/trafficserver/vaddrs.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/vaddrs.config"),
#   }
#
#   file{"/etc/trafficserver/volume.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/volume.config"),
#   }

#   file{"/etc/trafficserver/plugin/background_fetch.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/background_fetch.config"),
#   }

#   file{"/usr/lib64/trafficserver/plugins/add_header_hit.so":
#      ensure  =>  file,
#      mode    =>  755,
#      content => template("ats_cdn_dev/add_header_hit.so"),
#   }

#   file{"/etc/trafficserver/plugin/cacheurl.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cdn_dev/cacheurl.config"),
#   }

#  exec{"/etc/trafficserver/records.config.sh":
#    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
#    subscribe => [  File["/etc/trafficserver/records.config_tmp"],
#                 ],
#    refreshonly => true,
#  }

#  exec{"/usr/bin/traffic_line -x":
#  exec{"/etc/init.d/trafficserver restart":
#    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
#    subscribe => [  #File["/etc/trafficserver/cache.config"],
#                    #File["/etc/trafficserver/cluster.config"],
#                    #File["/etc/trafficserver/congestion.config"],
#                    #File["/etc/trafficserver/hosting.config"],
#                    #File["/etc/trafficserver/icp.config"],
#                    #File["/etc/trafficserver/ip_allow.config"],
#                    #File["/etc/trafficserver/log_hosts.config"],
#                    #File["/etc/trafficserver/logs_xml.config"],
#                    #File["/etc/trafficserver/parent.config"],
#                    File["/etc/trafficserver/plugin.config"],
#                    #File["/etc/trafficserver/prefetch.config"],
#                    #File["/etc/trafficserver/proxy.pac"],
#                    #File["/etc/trafficserver/records.config"],
#                    File["/etc/trafficserver/remap.config"],
#                    #File["/etc/trafficserver/socks.config"],
#                    #File["/etc/trafficserver/splitdns.config"],
#                    #File["/etc/trafficserver/ssl_multicert.config"],
#                    #File["/etc/trafficserver/stats.config.xml"],
#                    #File["/etc/trafficserver/update.config"],
#                    #File["/etc/trafficserver/vaddrs.config"],
#                    #File["/etc/trafficserver/volume.config"],
#                    File["/etc/trafficserver/plugin/background_fetch.config"],
#                    File["/etc/trafficserver/plugin/cacheurl.config"],
#                    #File["/usr/lib64/trafficserver/plugins/add_header_hit.so"],
#                 ],
#      refreshonly => true,
#  }
}
