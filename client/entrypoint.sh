#!/bin/bash

# filename: entrypoint.sh

# MONGODB_NODES examples
# MONGODB_NODES=172.10.17.101,172.10.17.102,172.10.17.103,172.10.17.104
# export MONGODB_NODES=172.10.17.101,172.10.17.102,172.10.17.103,172.10.17.104

if [ -z "$ENNAME" ];then
    ENNAME=eth0
fi
localip=`ip addr show $ENNAME|grep "inet.*brd.*$ENNAME"|awk '{print $2}'|awk -F/ '{print $1}'`
dcos_key="core.dcos_url"
dcos_value="http://$localip"

dcos config set $dcos_key $dcos_value



newline="mongod.product.uri=mongodb:\/\/"

string=$MONGODB_NODES
# split to IP array
array=(${string//,/ })
for i in "${!array[@]}"
do
    echo "${array[i]}"
    item="${array[i]}:27017,"
    echo "$item"
    newline=$newline$item
    echo $newline
done

# replace last ,
newline=${newline::-1}

echo "Final newline"
echo $newline

# replace line
# oldline
# mongod.product.uri=...
# newline
# $newline

sed -i "s/mongod\.product\.uri=.*/${newline}/" /linker/dcos_client.properties

tail /linker/dcos_client.properties

# start
# DO NOT USE nohup
/linker/dcos_client -config=/linker/dcos_client.properties

