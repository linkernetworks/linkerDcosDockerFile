#!/bin/bash

docker run -d \
-v /data/logs:/var/log/marketplace \
-v /usr/local/bin/controller.properties:/usr/local/bin/controller.properties \
--name=marketplace-controller --net=host  marketplace_controller:mwcdemo 



