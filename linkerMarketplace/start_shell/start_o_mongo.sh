#!/bin/bash

docker run -d \
-v /data/mongo:/data/db \
--name=o-mongo --net=host --restart=always mongo:3.2

