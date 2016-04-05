#!/bin/bash
/etc/init.d/cron start
nginx -g 'daemon off; error_log /dev/stderr info;'
