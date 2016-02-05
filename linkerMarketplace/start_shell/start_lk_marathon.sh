#!/bin/bash

source ./env_init.sh

docker run -d \
-e linker_marketplace=10.10.10.18 \
-e ZOOKEEPERLIST=${ZOOKEEPERLIST} \
-e MESOS_ZK=${MESOS_ZK} \
-e MESOS_MASTER=${MESOS_MASTER} \
-e MARATHON_MASTER=${MARATHON_MASTER} \
-e MARATHON_ZK=${MARATHON_ZK} \
-e MESOS_HOSTNAME_LOOKUP=false \
--name=lk-marathon --net=host --restart=always linkerrepository/marathon /entrypoint.sh 



