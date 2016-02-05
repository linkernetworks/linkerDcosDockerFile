#!/bin/bash
echo "stop cicd"
kill -9 `ps aux | grep -e "/usr/local/bin/cicd" | grep -v grep | awk '{print $2}'`
