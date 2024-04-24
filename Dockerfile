FROM ubuntu:jammy
# Enable systemd.
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends sudo systemd systemd-sysv \ 
    dialog net-tools git curl iputils-ping lsb-release locales \
 python3 python3-dev python3-pip python3-setuptools netcat-openbsd wget curl git sudo \ 
 coreutils bc file pollinate openssh-client unzip unattended-upgrades cron ntp fail2ban rsyslog software-properties-common \
 gnupg2 nsd ldnsutils openssh-client bind9 ca-certificates postfix postfix-sqlite postfix-pcre postgrey ca-certificates \
 dovecot-core dovecot-imapd dovecot-pop3d dovecot-lmtpd dovecot-sqlite sqlite3 dovecot-sieve dovecot-managesieved \
 opendkim opendkim-tools opendmarc \
 spampd razor pyzor dovecot-antispam libmail-dkim-perl \
 gettext python3-setuptools python3-dev librsync-dev gcc openssh-server && \
 add-apt-repository -y universe && \
 add-apt-repository -y ppa:duplicity-team/duplicity-release-git && \
 add-apt-repository --y ppa:ondrej/php && \
 git clone --branch dev https://gitlab.com/duplicity/duplicity.git && \
 cd duplicity && \
 python3 setup.py install --prefix=/usr/local && \
 apt-get clean && \
    touch /var/log/syslog /var/log/auth.log && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ; \
    cd /lib/systemd/system/sysinit.target.wants/ ; \
    ls | grep -v systemd-tmpfiles-setup | xargs rm -f $1 ; \
    rm -f /lib/systemd/system/multi-user.target.wants/* ; \
    rm -f /etc/systemd/system/*.wants/* ; \
    rm -f /lib/systemd/system/local-fs.target.wants/* ; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev* ; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl* ; \
    rm -f /lib/systemd/system/basic.target.wants/* ; \
    rm -f /lib/systemd/system/anaconda.target.wants/* ; \
    rm -f /lib/systemd/system/plymouth* ; \
    rm -f /lib/systemd/system/systemd-update-utmp*

STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
COPY ./install.sh /
COPY ./spampd.sh /
EXPOSE 80
EXPOSE 443
EXPOSE 993
EXPOSE 995
EXPOSE 25
EXPOSE 465
EXPOSE 587
EXPOSE 4190
EXPOSE 53
EXPOSE 10025
