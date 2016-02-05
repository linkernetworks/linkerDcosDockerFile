#!/bin/bash
echo "start cicd"

nohup /usr/local/bin/cicd --config /usr/local/bin/cicd.properties > /var/log/marketplace/cicd.log 2>&1
