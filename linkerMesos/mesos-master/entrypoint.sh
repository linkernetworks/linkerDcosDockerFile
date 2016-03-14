#!/bin/bash
if [ -z "$ENNAME" ];then
    ENNAME=eth0
fi
localip=`ip addr show $ENNAME|grep "inet.*brd.*$ENNAME"|awk '{print $2}'|awk -F/ '{print $1}'`

export MESOS_IP=$localip
tmpHost=${HOSTNAME//./_}
finalHost=${tmpHost//-/_}
advertiseip=`eval echo '$'$finalHost`
export MESOS_HOSTNAME=$localip
if [[ -n $advertiseip ]]; then
    export MESOS_ADVERTISE_IP=$advertiseip
fi
mesos-master
