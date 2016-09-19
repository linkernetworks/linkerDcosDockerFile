#!/bin/bash
localip=`/opt/mesosphere/bin/detect_ip`

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
mesos-master
