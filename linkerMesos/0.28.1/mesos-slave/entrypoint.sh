#!/bin/bash
if [ -z "$ENNAME" ];then
    ENNAME=eth0
fi
localip=`ip addr show $ENNAME|grep "inet.*brd.*$ENNAME"|awk '{print $2}'|awk -F/ '{print $1}'`

export MESOS_IP=$localip

hostNamePrefix="linker_hostname_"
tmpHost=${HOSTNAME//./_}
finalHost=${tmpHost//-/_}
finalHost=$hostNamePrefix$finalHost 
advertiseip=`eval echo '$'$finalHost`
export MESOS_HOSTNAME=$hostname
if [[ -n $advertiseip ]]; then
    export MESOS_ADVERTISE_IP=$advertiseip
fi

#!set mesos attributes env
attrLabel=`docker info | grep \s*"LINKER_MESOS_ATTRIBUTE="`
if [[ -n $attrLabel ]]; then
   value=`echo $attrLabel |awk -F '=' '{print $2}'`
   if [[ -n $value ]]; then
     export MESOS_ATTRIBUTES=$value
   fi
fi
 
mesos-slave
