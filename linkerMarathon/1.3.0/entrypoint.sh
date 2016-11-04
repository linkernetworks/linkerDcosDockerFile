#!/bin/bash
if [ -z "$ENNAME" ];then
    ENNAME=eth0
fi
localip=`ip addr show $ENNAME|grep "inet.*brd.*$ENNAME"| head -1 |awk '{print $2}'|awk -F/ '{print $1}'`
export MARATHON_HTTP_ADDRESS=$localip
export MARATHON_HTTPS_ADDRESS=$localip

hostNamePrefix="linker_hostname_"
tmpHost=${HOSTNAME//./_}
finalHost=${tmpHost//-/_}
finalHost=$hostNamePrefix$finalHost 
#export MARATHON_HOSTNAME=`eval echo '$'$finalHost`
export MARATHON_HOSTNAME=$localip

#--no-logger dose not mean that do not log, but means do not log to syslog
marathon --no-logger
