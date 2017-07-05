#!/bin/bash
# name: mongrel_puppetmasterd
# Start multi Puppet Master Server instance with diffrrent port.

#for i in 18140 28140 38140 48140 17140 27140 37140 47140 16140 26140;do MASTERPORT="$i";
for i in 8141;do MASTERPORT="$i";
#for i in 18140 28140 38140 48140 17140 27140 37140 47140 16140 26140 36140 46140;do MASTERPORT="$i";
shift

/usr/sbin/puppetmasterd  \
--pidfile=/var/run/puppet/puppetmasterd."${MASTERPORT}".pid \
--servertype=mongrel \
--ssl_client_header=HTTP_X_SSL_SUBJECT \
--masterport="${MASTERPORT}" \
$*
done
