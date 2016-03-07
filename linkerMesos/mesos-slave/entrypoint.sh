#!/bin/bash
if [ -z "$ENNAME" ];then
    ENNAME=eth0
fi
localip=`ip addr show $ENNAME|grep "inet.*brd.*$ENNAME"|awk '{print $2}'|awk -F/ '{print $1}'`

export MESOS_IP=$localip
tmpHost=${HOSTNAME//./_}
finalHost=${tmpHost//-/_}
export MESOS_HOSTNAME=`eval echo '$'$finalHost`

#!set mesos attributes env
attrLabel=`docker info | grep \s*"LINKER_MESOS_ATTRIBUTE="`
if [[ -n $attrLabel ]]; then
   value=`echo $attrLabel |awk -F '=' '{print $2}'`
   if [[ -n $value ]]; then
     export MESOS_ATTRIBUTES=$value
   fi
fi
mesos-slave
