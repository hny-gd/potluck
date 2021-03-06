#!/bin/sh

[ -w /etc/pkg/FreeBSD.conf ] && sed -i '' 's/quarterly/latest/' /etc/pkg/FreeBSD.conf
ASSUME_ALWAYS_YES=yes pkg bootstrap
touch /etc/rc.conf
sysrc sendmail_enable="NONE"
pkg install -y nginx
echo "error_log /dev/stderr;" >> /usr/local/etc/nginx/nginx.conf
sed -i '' 's%#access_log  logs/access.log .*$%access_log /dev/stdout combined;%' /usr/local/etc/nginx/nginx.conf
pkg clean -y
