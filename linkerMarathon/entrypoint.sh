#!/bin/bash
if [ -z "$ENNAME" ];then
    ENNAME=eth0
fi
localip=`ip addr show $ENNAME|grep "inet.*brd.*$ENNAME"|awk '{print $2}'|awk -F/ '{print $1}'`
export MARATHON_HTTP_ADDRESS=$localip
export MARATHON_HTTPS_ADDRESS=$localip
tmpHost=${HOSTNAME//./_}
finalHost=${tmpHost//-/_}
#export MARATHON_HOSTNAME=`eval echo '$'$finalHost`
export MARATHON_HOSTNAME=$localip
marathon --no-logger --event_subscriber http_callback
