####nginx config file###
class ats_cloud::config {
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
#      content => template("ats_cloud/cache.config"),
#   }

#   file{"/etc/trafficserver/cluster.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cloud/cluster.config"),
#   }
#
#   file{"/etc/trafficserver/congestion.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cloud/congestion.config"),
#   }
#
#   file{"/etc/trafficserver/hosting.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cloud/hosting.config"),
#   }
#
#   file{"/etc/trafficserver/icp.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cloud/icp.config"),
#   }
#
#   file{"/etc/trafficserver/ip_allow.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cloud/ip_allow.config"),
#   }
#
#   file{"/etc/trafficserver/log_hosts.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cloud/log_hosts.config"),
#   }
#
#   file{"/etc/trafficserver/logs_xml.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cloud/logs_xml.config"),
#   }
#
#   file{"/etc/trafficserver/parent.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cloud/parent.config"),
#   }

#   file{"/etc/trafficserver/plugin.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cloud/plugin.config"),
#   }

#   file{"/etc/trafficserver/prefetch.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cloud/prefetch.config"),
#   }

#   file{"/etc/trafficserver/proxy.pac":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cloud/proxy.pac"),
#   }
#
#   file{"/etc/trafficserver/records.config_tmp":
#      ensure  =>  file,
#      mode    =>  600,
#      content => template("ats_cloud/records.config"),
#      require =>  File['/etc/trafficserver/records.config.sh'],
#   }
#
#   file{"/etc/trafficserver/records.config.sh":
#      ensure  =>  file,
#      mode    =>  755,
#      content => template("ats_cloud/records.config.sh"),
#   }

#   file{"/etc/trafficserver/remap.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cloud/remap.config"),
#   }

#   file{"/etc/trafficserver/socks.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cloud/socks.config"),
#   }
#
#   file{"/etc/trafficserver/splitdns.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cloud/splitdns.config"),
#   }
#
#   file{"/etc/trafficserver/ssl_multicert.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cloud/ssl_multicert.config"),
#   }
#
#   file{"/etc/trafficserver/stats.config.xml":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cloud/stats.config.xml"),
#   }
#
#   file{"/etc/trafficserver/update.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cloud/update.config"),
#   }
#
#   file{"/etc/trafficserver/vaddrs.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cloud/vaddrs.config"),
#   }
#
#   file{"/etc/trafficserver/volume.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cloud/volume.config"),
#   }

#   file{"/etc/trafficserver/plugin/background_fetch.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cloud/background_fetch.config"),
#   }

#   file{"/usr/lib64/trafficserver/plugins/add_header_hit.so":
#      ensure  =>  file,
#      mode    =>  755,
#      content => template("ats_cloud/add_header_hit.so"),
#   }

#   file{"/etc/trafficserver/plugin/cacheurl.config":
#      ensure  =>  file,
#      mode    =>  644,
#      owner   =>  'ats',
#      group   =>  'ats',
#      content => template("ats_cloud/cacheurl.config"),
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
