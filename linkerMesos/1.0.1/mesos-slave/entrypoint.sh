#!/bin/bash
if [ -z "$ENNAME" ];then
    ENNAME=eth0
fi
localip=`ip addr show $ENNAME|grep "inet.*brd.*$ENNAME"|head -1|awk '{print $2}'|awk -F/ '{print $1}'`

export MESOS_IP=$localip
export MESOS_HOSTNAME=$localip

#!set mesos attributes env
attrLabel=`docker info | grep \s*"LINKER_MESOS_ATTRIBUTE="`
if [[ -n $attrLabel ]]; then
   value=`echo $attrLabel |awk -F '=' '{print $2}'`
   if [[ -n $value ]]; then
     export MESOS_ATTRIBUTES=$value
   fi
   #it's shared node
   if [[ $value =~ "lb:enable" ]]; then
   	 export MESOS_DEFAULT_ROLE="slave_public"
   	 export MESOS_RESOURCES="ports(slave_public):[1-21,23-5050,5052-9999,10001-32000]"
   else  #pure slave node with customized label
   	 export MESOS_RESOURCES="ports(*):[1025-2180,2182-3887,3889-5049,5052-8079,8082-8180,8182-9999, 10001-32000]"
   fi
else  # pure salve node without any customized label
    export MESOS_RESOURCES="ports(*):[1025-2180,2182-3887,3889-5049,5052-8079,8082-8180,8182-9999, 10001-32000]"
fi
 
mesos-slave
