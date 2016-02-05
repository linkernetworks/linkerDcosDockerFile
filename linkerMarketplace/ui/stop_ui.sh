#!/bin/bash
echo "stop ui"
kill -9 `ps aux | grep -e "/usr/local/bin/linker_controller_portal/portal-server/server.js" | grep -v grep | awk '{print $2}'`
