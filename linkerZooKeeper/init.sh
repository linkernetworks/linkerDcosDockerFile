#!/bin/bash

if [ -z $CONFIG ];then
    CONFIG="/usr/zookeeper-3.4.7/conf"
fi

if [ ! -z "$ZOOKEEPERLIST" ];then
    if [ -z "$ENNAME" ];then
	ENNAME=eth0
    fi
    localip=`ip addr show $ENNAME|grep "inet.*brd.*$ENNAME"|awk '{print $2}'|awk -F/ '{print $1}'`
    zks=""
    i=1
    for server in `echo $ZOOKEEPERLIST|sed 's/\,/ /g'`;do
	zks+="server.$i=$server\n"
	ip=${server%%:*}
	if [ "$ip" == "$localip" ];then
		ZKID=$i
	fi
	let i=$i+1
    done

    echo $ZKID > /data/zookeeper/snapshot/myid && \
    sed -i 's/--serverlist--/'$zks'/g' $CONFIG/zookeeper.cfg
else
    sed -i 's/--serverlist--//g' $CONFIG/zookeeper.cfg
fi

/usr/zookeeper-3.4.7/bin/zkServer.sh start-foreground /usr/zookeeper-3.4.7/conf/zookeeper.cfg
