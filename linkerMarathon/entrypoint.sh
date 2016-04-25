#!/bin/bash
if [ -z "$ENNAME" ];then
    ENNAME=eth0
fi
localip=`ip addr show $ENNAME|grep "inet.*brd.*$ENNAME"|awk '{print $2}'|awk -F/ '{print $1}'`
export MARATHON_HTTP_ADDRESS=$localip
export MARATHON_HTTPS_ADDRESS=$localip

hostNamePrefix="linker_hostname_"
tmpHost=${HOSTNAME//./_}
finalHost=${tmpHost//-/_}
finalHost=$hostNamePrefix$finalHost 
#export MARATHON_HOSTNAME=`eval echo '$'$finalHost`
export MARATHON_HOSTNAME=$localip

http_endpoints="http://master.mesos:10004/v1/marathon/notify"
marathon --no-logger --event_subscriber http_callback --http_endpoints $http_endpoints
