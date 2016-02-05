#!/bin/bash

source ./env_init.sh

docker run -d \
-e linker_marketplace=10.10.10.18 \
-e ZOOKEEPERLIST=${ZOOKEEPERLIST} \
-e MESOS_ZK=${MESOS_ZK} \
-e MESOS_MASTER=${MESOS_MASTER} \
-e MESOS_LOG_DIR=/var/log/mesos \
-e MESOS_QUORUM=1 \
-e MESOS_REGISTRY=in_memory \
-e MESOS_WORK_DIR=/var/lib/mesos \
--name=lk-mesos-master --net=host --restart=always linkerrepository/mesos-master /entrypoint.sh

