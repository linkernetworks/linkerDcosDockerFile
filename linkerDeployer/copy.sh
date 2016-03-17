#!/bin/bash

set -x

pubkey=$1
privatekey=$2
user=$3
ip=$4

cat ${pubkey} | ssh -i ${privatekey} ${user}@${ip} "mkdir -p ~/.ssh;cat >> ~/.ssh/authorized_keys"
