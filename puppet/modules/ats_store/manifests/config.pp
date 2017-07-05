class ats_store::config {
   file{"/usr/local/etc/ats":
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

#   file{"/usr/local/etc/ats/remap.config":
#      ensure  =>  file,
#      mode    =>  600,
#      owner   =>  'root',
#      group   =>  'root',
#      content => template("ats_store/remap.config"),
#   }
#
   file{"/usr/local/etc/ats/plugin/cacheurl.config":
      ensure  =>  file,
      mode    =>  600,
      owner   =>  'root',
      group   =>  'root',
      content => template("ats_store/cacheurl.config"),
   }
#
#  exec{"/usr/local/sbin/ats/bin/traffic_line -x":
  exec{"/usr/local/sbin/ats/bin/trafficserver restart":
    path      => "/usr/bin:/usr/sbin:/bin:/usr/local/bin:/bin/:/sbin",
    subscribe => [  #File["/usr/local/etc/ats/remap.config"],
                    File["/usr/local/etc/ats/plugin/cacheurl.config"],
                 ],
      refreshonly => true,
  }
}
