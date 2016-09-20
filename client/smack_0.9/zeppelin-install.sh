#!/bin/bash

line=`dcos package list|grep zeppelin |awk '{print $3}'|grep zeppelin|wc -l`

echo zeppelin installed=$line

if [[ $line -eq 1 ]]; then
   echo zeppelin already installed
else
   echo to install zeppelin..
   dcos package install --package-version=0.5.6 --yes --options=zeppelin.json zeppelin
   echo zeppelin already installed
fi
