#!/bin/bash

docker run -d \
-v /data/logs:/var/log/marketplace \
-v /usr/local/bin/linker-portal.json:/usr/local/bin/linker_controller_portal/portal-server/conf/linker-portal.json \
--name=marketplace-ui --net=host  marketplace_ui:mwcdemo 



