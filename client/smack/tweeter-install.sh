#! /bin/bash

line=`dcos marathon app list|grep \/tweeter|wc -l`

echo tweeter installed=$line

if [[ $line -eq 1 ]]; then
   echo tweeter already installed.
else
   echo to install tweeter..
   dcos marathon app add tweeter.json
   echo tweeter already installed.
fi

