#!/bin/bash
if [ -z "$ENNAME" ];then
    ENNAME=eth0
fi
localip=`ip addr show $ENNAME|grep "inet.*brd.*$ENNAME"|awk '{print $2}'|awk -F/ '{print $1}'`

export MESOS_IP=$localip

# hostNamePrefix="linker_hostname_"
# tmpHost=${HOSTNAME//./_}
# finalHost=${tmpHost//-/_}
# finalHost=$hostNamePrefix$finalHost 
# advertiseip=`eval echo '$'$finalHost`
export MESOS_HOSTNAME=$localip
# if [[ -n $advertiseip ]]; then
#     export MESOS_ADVERTISE_IP=$advertiseip
# fi

#!set mesos attributes env
attrLabel=`docker info | grep \s*"LINKER_MESOS_ATTRIBUTE="`
if [[ -n $attrLabel ]]; then
   value=`echo $attrLabel |awk -F '=' '{print $2}'`
   if [[ -n $value ]]; then
     export MESOS_ATTRIBUTES=$value
   fi
   if [[ $value =~ "public_ip:true" ]]; then
   	 export MESOS_DEFAULT_ROLE="slave_public"
   	 export MESOS_RESOURCES="ports(*):[1-21,23-5050,5052-32000]"
   else 
   	 export MESOS_RESOURCES="ports(*):[1025-2180,2182-3887,3889-5049,5052-8079,8082-8180,8182-32000]"
   fi
fi
 
mesos-slave
