#!/bin/bash
echo "start controller"
nohup /usr/local/bin/controller --config /usr/local/bin/controller.properties > /var/log/marketplace/controller.log 2>&1
