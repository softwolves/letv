class ats_cloud_dev::config {
   file{"/usr/local/etc/ats":
      ensure  =>  directory,
      mode    =>  755,
      owner   =>  'root',
      group   =>  'root',
   }

   file{"/usr/local/sbin/ats/libexec":
      ensure  =>  directory,
      mode    =>  755,
      owner   =>  'root',
      group   =>  'root',
   }

   file{"/usr/local/sbin/ats/libexec/trafficserver":
      ensure  =>  directory,
      mode    =>  755,
      owner   =>  'root',
      group   =>  'root',
   }

   file{"/usr/local/etc/ats/plugin":
      ensure  =>  directory,
      mode    =>  755,
      owner   =>  'root',
      group   =>  'root',
   }

#   file{"/usr/local/sbin/ats/libexec/trafficserver/background_fetch.so":
#      ensure  =>  file,
#      mode    =>  755,
#      content => template("ats_cloud_dev/background_fetch.so"),
#   }
#
#   file{"/usr/local/sbin/ats/libexec/trafficserver/add_header_hit.so":
#      ensure  =>  file,
#      mode    =>  755,
#      content => template("ats_cloud_dev/add_header_hit.so"),
#   }
#
#   file{"/usr/local/etc/ats/plugin.config":
#      ensure  =>  file,
#      mode    =>  644,
#      content => template("ats_cloud_dev/plugin.config"),
#   }

   file{"/usr/local/etc/ats/remap.config":
      ensure  =>  file,
      mode    =>  644,
      content => template("ats_cloud_dev/remap.config"),
   }

   file{"/usr/local/etc/ats/plugin/cacheurl.config":
      ensure  =>  file,
      mode    =>  644,
      content => template("ats_cloud_dev/cacheurl.config"),
   }
#
#   file{"/usr/local/etc/ats/plugin/background_fetch.config":
#      ensure  =>  file,
#      mode    =>  644,
#      content => template("ats_cloud_dev/background_fetch.config"),
#   }
#  exec{"/usr/local/sbin/ats/bin/trafficserver restart":
#    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
#    subscribe => [  File["/usr/local/sbin/ats/libexec/trafficserver/background_fetch.so"],
#		    File["/usr/local/sbin/ats/libexec/trafficserver/add_header_hit.so"],
#                 ],
#      refreshonly => true,
#  }

#  exec{"/usr/local/sbin/ats/bin/traffic_line -x":
  exec{"/usr/local/sbin/ats/bin/trafficserver restart":
    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => [  File["/usr/local/etc/ats/remap.config"],
                    File["/usr/local/etc/ats/plugin/cacheurl.config"],
                    #File["/usr/local/etc/ats/plugin.config"],
                    #File["/usr/local/etc/ats/plugin/background_fetch.config"],
                 ],
      refreshonly => true,
  }
}
