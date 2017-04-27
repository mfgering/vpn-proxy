#!/bin/sh
OPENVPN_CONFG=/vol/config/openvpn.conf

DANTE_OPTS="--script-security 2 --up /usr/sbin/start_dante.sh --down /usr/sbin/stop_dante.sh"

if [ -n "${LOCAL_NETWORK-}" ]; then
  eval $(/sbin/ip r l m 0.0.0.0 | awk '{if($5!="tun0"){print "GW="$3"\nINT="$5; exit}}')
  if [ -n "${GW-}" -a -n "${INT-}" ]; then
    echo "adding route to local network $LOCAL_NETWORK via $GW dev $INT"
    /sbin/ip r a "$LOCAL_NETWORK" via "$GW" dev "$INT"
  fi
fi
# Persist dante settings for use by start_dante.sh
dockerize -template /etc/dante/dante-env-vars.tmpl:/etc/dante/dante-env-vars.sh /bin/true

exec openvpn $DANTE_OPTS $OPENVPN_OPTS --config "$OPENVPN_CONFIG"
