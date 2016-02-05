#!/bin/bash

source ./env_init.sh

docker run -d \
-v /data/logs:/var/log/marketplace \
-v /sys/fs/cgroup:/sys/fs/cgroup \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /usr/local/bin/linkerexecutor:/usr/local/bin/linkerexecutor \
-v /usr/local/bin/executor.properties:/usr/local/bin/executor.properties \
-v /usr/local/bin/startExecutor.sh:/usr/local/bin/startExecutor.sh \
-e linker_marketplace=10.10.10.18 \
-e ZOOKEEPERLIST=${ZOOKEEPERLIST} \
-e MESOS_ZK=${MESOS_ZK} \
-e MESOS_MASTER=${MESOS_MASTER} \
-e MESOS_CONTAINERIZERS=docker,mesos \
-e MESOS_LOG_DIR=/var/log/mesos \
-e MESOS_LOGGING_LEVEL=INFO \
--name=lk-mesos-slave --net=host --restart=always linkerrepository/mesos-slave /entrypoint.sh

