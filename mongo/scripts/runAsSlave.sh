#!/bin/bash

getMaster() {
 OLD_IFS="$IFS" 
 IFS="," 
 arr=($IPs) 
 IFS="$OLD_IFS" 
 for s in ${arr[@]} 
 do 
     # echo "$s" 
     if [[ "$s" != "$currentIP" ]]; then
       	isMaster=`mongo $s --quiet --eval "d=db.isMaster(); print( d['ismaster'] ); quit();"`
       	if [[ "$isMaster" == "true" ]];then
       		echo "$s"
       	fi
     
     fi

    let "masterCount +=1"
 done
}

ifname=${ENNAME:-eth0}
currentIP=`ifconfig $ifname | grep "inet " |cut -d: -f2| awk '{print $2}'`
IPs=${MONGODB_NODES}
ReplSetName=${MONGODB_REP_NAME:-linkerSet}
PASS=${MONGODB_PASSWORD:-password}
ADMINDB="admin"
ADMINUSER="rootadmin"
if [[  -z "$IPs" ]]; then
	echo "invalid parameter, no mongodb host ips!"
	exit 10
fi

masterNode=`getMaster`
if [[ -z "$masterNode" ]]; then
	echo "does not find current master node!"
	exit 10
else
	echo "current master node is $masterNode"
	echo "1.Staring MongoDB in added Slave node..."
    nohup /usr/bin/mongod --dbpath /data/db --keyFile /key/mongodb-keyfile --replSet "$ReplSetName" &
    echo "waiting for mongo starup..."
  # wait until mongo started
  # while ! netstat -alp | grep 27017; do sleep 1; done 
    RET=1
    while [[ RET -ne 0 ]]; do
      echo "=> Waiting for confirmation of MongoDB service startup"
      sleep 2
      mongo $ADMINDB --eval "help" >/dev/null 2>&1
      RET=$?
    done

    echo "2.add slave node to mongo replSet..."
    cmd2="db.auth('$ADMINUSER', '$PASS'); rs.add('$currentIP'); quit();"
    newcmd2=$cmd2
	mongo "$masterNode/$ADMINDB"  --eval "$newcmd2" 

	echo "3.restart slave mongod as non deamon..."
    /usr/bin/mongod --shutdown
    sleep 5
    /usr/bin/mongod --dbpath /data/db --keyFile /key/mongodb-keyfile --replSet "$ReplSetName"
fi
