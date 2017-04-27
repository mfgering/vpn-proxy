#!/bin/sh
# This script will be called with tun/tap device name as parameter 1, and local IP as parameter 4
# See https://openvpn.net/index.php/open-source/documentation/manuals/65-openvpn-20x-manpage.html (--up cmd)

# Source our persisted env variables from container startup
. /etc/dante/dante-env-vars.sh

sed -i "s/.*external:.*/external: $1/" $CFGFILE
echo "STARTING DANTE"
exec sockd -D -f $CFGFILE -p $PIDFILE -N $WORKERS
