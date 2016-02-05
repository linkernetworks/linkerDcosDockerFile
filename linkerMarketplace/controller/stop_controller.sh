#!/bin/bash
echo "stop controller"
kill -9 `ps aux | grep -e "/usr/local/bin/controller" | grep -v grep | awk '{print $2}'`
