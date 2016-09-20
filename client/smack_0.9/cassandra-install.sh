#!/bin/bash

line=`dcos package list|grep cassandra |awk '{print $3}'|grep cassandra|wc -l`

echo cassandra installed=$line

if [[ $line -eq 1 ]]; then
   echo cassandra already installed
else
   echo to install cassandra
   echo to clear cassandra on zk
   ./zk -zk master.mesos:2181 -path /cassandra
   echo clear cassandra on zk finish
   dcos package install --yes --package-version=1.0.7-2.2.5 --options=cassandra_2.2.5.json  cassandra
fi


function getCassandraNodeLen(){
  serviceJson=`curl -s master.mesos:8123/v1/services/_cassandra._tcp.marathon.mesos`
  cassandraAddr=""
  nodes="0"

  if [[ $serviceJson == "" ]]; then
    echo service not exist
  else
    cassandraAddr=`echo $serviceJson | python -c 'import sys, json; j = json.load(sys.stdin); print(j[0]["ip"] + ":" + j[0]["port"])'`
  fi

  echo cassandraAddr=$cassandraAddr
  if [[ $cassandraAddr != "" ]]; then
    nodeJson=`curl -s $cassandraAddr/v1/nodes/connect`
    if [[ $nodeJson != "" ]]; then
      nodes=`echo $nodeJson|python -c 'import sys, json; j = json.load(sys.stdin);print(len(j["address"]))'`
    fi
  fi
  echo nodes=$nodes
  return $nodes
}

#echo wait for cassandra startup...
while true; do
  getCassandraNodeLen
  if [[ $? -gt 0 ]]; then
    break
  else
    echo wait for cassandra startup ...
    sleep 5
  fi
done
echo cassandra startup!
