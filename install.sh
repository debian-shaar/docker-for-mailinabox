#!/bin/bash
sudo systemctl enable --now ssh
sudo git clone https://github.com/mail-in-a-box/mailinabox
cd mailinabox
git checkout v68
sed -i "s/SSH_PORT=/SSH_PORT=22\#/" /mailinabox/setup/system.sh
sed -i "s/rm -f \/etc\/resolv.conf/echo rm -f \/etc\/resolv.conf || true/" /mailinabox/setup/system.sh
sed -i "s/echo \"nameserver 127.0.0.1/\#echo \"nameserver 127.0.0.1/" /mailinabox/setup/system.sh
sed -i "s/PHP_VER=8.0/PHP_VER=8.1;DISABLE_FIREWALL=0/" /mailinabox/setup/functions.sh
#sed -i "s/\# Get a/echo \$@; \# Get a/" /mailinabox/setup/functions.sh
sed -i "s/hide_output service \$1 restart/return \#hide_output service \$1 restart/" /mailinabox/setup/functions.sh
sed -i "s/DEBIAN_FRONTEND=noninteractive hide_output apt-get -y/DEBIAN_FRONTEND=noninteractive hide_output apt-get --no-install-recommends -y/" /mailinabox/setup/functions.sh
sed -i "s/php8.0-fpm/php8.1-fpm/" /mailinabox/conf/nginx-top.conf
sed -i "s/php8.0-fpm/php8.1-fpm/" /mailinabox/tools/owncloud-restore.sh
sed -i "s/php8.0-fpm/php8.1-fpm/" /mailinabox/management/backup.py
sed -i "s/restart_service munin-node/sed -i \"s\/\^PIDFile=\/\#PIDFile\/\" \/usr\/lib\/systemd\/system\/spampd.service;sed -i \"s\/\^PIDFile=\/\#PIDFile\/\" \/usr\/lib\/systemd\/system\/opendkim.service;sed -i \"s\/-xf\/-xfv\/\" \/lib\/systemd\/system\/fail2ban.service;sed -i \"s\/\^PIDFile=\/\#PIDFile\/\" \/usr\/lib\/systemd\/system\/opendmarc.service; systemctl daemon-reload ;systemctl enable --now fail2ban postfix postgrey dovecot spampd nginx php8.1-fpm mailinabox munin opendkim opendmarc spamassassin spampd; systemctl start bind9 spampd; return/" /mailinabox/setup/munin.sh
sudo setup/start.sh
cd ..
bash spampd.sh
