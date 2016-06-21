#!/bin/bash

line=`dcos package list|grep kafka |awk '{print $3}'|grep kafka|wc -l`

echo kafka installed=$line

kafkaAddr=""
nodes="0"

function getKafkaAddr(){
  serviceJson=`curl -s master.mesos:8123/v1/services/_kafka._tcp.marathon.mesos`

  if [[ $serviceJson == "" ]]; then
    echo service not exist
  else
    kafkaAddr=`echo $serviceJson | python -c 'import sys, json; j = json.load(sys.stdin); print(j[0]["ip"] + ":" + j[0]["port"])'`
  fi
}

function waitKafkaFrameworkStartup(){
  while true; do
    getKafkaAddr
    if [[ $kafkaAddr != "" && $kafkaAddr != ":" ]]; then
      state=`curl -s $kafkaAddr/health`
      echo kafka.state=$state
      if [[ $state == "ok" ]]; then
        echo kafka framework startup!
        return;
      else
        echo kafka health exception, wait for framework start...
        sleep 2
      fi
    else
      sleep 2
      echo wait for framework start .. 
      #wait for framework start
    fi
  done
}


function getKafkaNodeLen(){
  getKafkaAddr
  nodes="0"

  #echo kafakaAddr=$kafkaAddr
  if [[ $kafkaAddr != "" && $kafkaAddr != ":" ]]; then
    nodeJson=`curl -s $kafkaAddr/api/broker/list`
    #echo nodeJson=$nodeJson
    if [[ $nodeJson != "" ]]; then
      nodes=`echo $nodeJson|python -c 'import sys, json; j = json.load(sys.stdin);print(len(j["brokers"]))'`
    fi
  fi
  #echo nodes=$nodes
  return $nodes
}

node0ip=""
node0state="false"
node0options=""
function getNode0(){
   node0state="false"
   node0ip=""
   getKafkaAddr

   if [[ $kafkaAddr != "" && $kafkaAddr != ":" ]]; then
    nodeJson=`curl -s $kafkaAddr/api/broker/list`
    #echo nodeJson=$nodeJson
    if [[ $nodeJson != "" ]]; then
      node0ip=`echo $nodeJson|python -c 'import sys, json; j = json.load(sys.stdin);print(j["brokers"][0]["task"]["hostname"])'`
      node0state=`echo $nodeJson|python -c 'import sys, json; j = json.load(sys.stdin);print(j["brokers"][0]["active"])'`
      node0options=`echo $nodeJson|python -c 'import sys, json; j = json.load(sys.stdin);print(j["brokers"][0]["options"])'`
      node0state=`echo $node0state|tr '[A-Z]' '[a-z]'`
    fi
  fi
  echo node0ip=$node0ip,node0options=$node0options,node0state=$node0state
}

if [[ $line -eq 1 ]]; then
   echo kafka already installed
else
   echo to install kafka
   #echo to clear kafka on zk
   #./zk -zk master.mesos:2181 -path /kafka-mesos
   #echo to clear kafka on zk finish
   dcos package install --yes --options=kafka.json --package-version=0.9.2.0 kafka
fi

waitKafkaFrameworkStartup

while true ; do
  echo to add broker 0
  dcos kafka broker add 0 --cpus 0.1 --port 9093
  
  getNode0
  if [[ $node0ip != "" &&  $node0options =~ 'advertised.host.name' && $node0state == 'true' ]] ; then
    echo broker 0 exist and started
    break;
  fi

  if [[ $node0ip == "" &&  $node0state != 'true' ]]; then
    echo to start broker 0
    dcos kafka broker start 0
  fi

  getNode0
  echo node0ip=$node0ip

  if [[ $node0state == 'true' ]]; then
    echo to stop broker 0
    dcos kafka broker stop 0
  fi

  echo to config broker 0 advertised.host.name
  dcos kafka broker update 0 --options advertised.host.name=$node0ip
  
  echo to restart broker 0
  dcos kafka broker start 0

  getNode0
  echo node0state=$node0state

  if [[ $node0ip != "" &&  $node0options =~ 'advertised.host.name' && $node0state == 'true' ]] ; then  
    echo broker 0 exist and started
    break
  fi
done

#echo wait for kafka broker startup...
while true; do
  getKafkaNodeLen
  echo nodes=$nodes
  if [[ $nodes -gt 0 ]]; then
    break
  else
    echo wait for kafka broker startup ...
    sleep 5
  fi
done
echo kafka startup!
