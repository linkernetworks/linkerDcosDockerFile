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
    echo kafkaAddr=$kafkaAddr
  fi
}

function waitKafkaFrameworkStartup(){
  while true; do
    getKafkaAddr
    if [[ $kafkaAddr != "" && $kafkaAddr != ":" ]]; then
      state=`curl -s $kafkaAddr/v1`
      echo kafka.state=$state
      if [[ $state =~ \{.*\} ]]; then
        echo kafka framework startup!
        state="ok"
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
    nodeJson=`curl -s $kafkaAddr/v1/brokers`
    #echo nodeJson=$nodeJson
    if [[ $nodeJson != "" ]]; then
      nodes=`echo $nodeJson|python -c 'import sys, json; j = json.load(sys.stdin);print(len(j["brokers"]))'`
    fi
  fi
  #echo nodes=$nodes
  return $nodes
}

node0ip=""
function getNode0(){
   node0ip=""
   getKafkaAddr

   if [[ $kafkaAddr != "" && $kafkaAddr != ":" ]]; then
    nodeJson=`curl -s $kafkaAddr/v1/connection`
    #echo nodeJson=$nodeJson
    if [[ $nodeJson != "" ]]; then
      nodes=`echo $nodeJson|python -c 'import sys, json; j = json.load(sys.stdin);print(len(j["address"]))'`
      if [[ $nodes -gt 0 ]]; then
        node0ip=`echo $nodeJson|python -c 'import sys, json; j = json.load(sys.stdin);print(j["address"][0])'`
      fi
    fi
  fi
  echo node0ip=$node0ip
}

if [[ $line -eq 1 ]]; then
   echo kafka already installed
else
   echo to install kafka
   echo to clear kafka on zk
   ./zk -zk master.mesos:2181 -path /kafka
   #echo to clear kafka on zk finish
   dcos package install --yes --options=kafka_1.0.7-0.9.0.1.json --package-version=1.0.7-0.9.0.1 kafka
fi

waitKafkaFrameworkStartup

while true ; do
  
  getNode0
  if [[ $node0ip != ""  ]] ; then
    echo broker 0 exist and started
    break;
  else
    sleep 3
  fi
done

echo kafka startup!
