#!/bin/bash
for i in {1..10}
do
  echo "testing"
  X=`ip a show eth0`
  if [[ $X != "" ]] ; then
    sockd -f $CFGFILE -p $PIDFILE -N $WORKERS
    exit 0; 
  fi
  sleep 5
done
exit 1