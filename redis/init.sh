#!/bin/bash

sed -i "/bind 127.0.0.1/d" /etc/redis.conf
/usr/bin/redis-server /etc/redis.conf