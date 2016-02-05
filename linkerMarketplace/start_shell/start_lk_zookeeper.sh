#!/bin/bash

source ./env_init.sh
docker run -d \
-e ZOOKEEPERLIST=${ZOOKEEPERLIST} \
--name=lk-zookeeper --net=host --restart=always linkerrepository/zookeeper /init.sh


