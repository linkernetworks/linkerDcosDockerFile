#!/bin/bash

conf_file=${conf_file:=/etc/resolv.conf}

while true; do
    /gen_resolvconf.py ${conf_file}
    sleep 30
done
