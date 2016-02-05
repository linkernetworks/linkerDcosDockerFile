#!/bin/bash

docker run -d \
-v /data/logs:/var/log/marketplace \
-v /usr/local/bin/cicd.properties:/usr/local/bin/cicd.properties \
--name=marketplace-cicd --net=host  marketplace_cicd:mwcdemo 



