#!/bin/bash
echo "start ui"
nohup node /usr/local/bin/linker_controller_portal/portal-server/server.js > /var/log/marketplace/ui.log 2>&1
