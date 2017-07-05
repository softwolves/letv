#/bin/bash
#用于从git仓库自动更新puppet配置文件

#if wget -Nq http://115.182.94.72/cdn/UPDATE -P  /usr/local/etc/;then
#        cd /usr/local/etc/
#        rm -rvf puppet
#        git clone git@115.182.63.171:puppet.git
#        rsync -avv --delete --exclude '.git/*'  /usr/local/etc/puppet/cdn/manifests /etc/puppet/
#        echo "rsync at `date '+%Y-%m-%d %H:%M:%S'`" >> /usr/local/etc/log/gitupdate.log
#fi

#if wget -Nq http://115.182.94.72/cdn/UPDATE -P  /usr/local/etc/;then
#        cd /usr/local/etc/
#        rm -rvf puppetnew
#        git clone git@115.182.63.171:puppetnew.git
#        rsync -avv --delete --exclude '.git/*'  /usr/local/etc/puppetnew/* /etc/puppet/
#        echo "rsync at `date '+%Y-%m-%d %H:%M:%S'`" >> /usr/local/etc/log/gitupdate.log

#fi


if wget -Nq http://115.182.94.72/cdn/UPDATE -P  /usr/local/etc/;then
        cd /usr/local/etc/
        rm -rvf puppetxo
        git clone git@115.182.63.171:puppetxo.git
        rsync -avv --delete --exclude '.git/*'  /usr/local/etc/puppetxo/* /etc/puppet/
        echo "rsync at `date '+%Y-%m-%d %H:%M:%S'`" >> /usr/local/etc/log/gitupdate.log
fi
