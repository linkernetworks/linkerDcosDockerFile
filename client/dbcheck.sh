#!/bin/bash

command_exists() {
        command -v "$@" > /dev/null 2>&1
}

isMongoRunning() {
	server=$1
	port=$2
    echo "quit" | telnet $server $port | grep "Escape character is"
    if [ "$?" -ne 0 ]; then
        echo "Connection to $server on port $port failed"
        return 1
    else
        echo "Connection to $server on port $port succeeded"
        return 0
    fi
}

isMongoReady() {
	ip=$1
	maxtry=50
	count=0

    command_exists telnet
    if [[ $? -ne 0 ]]; then
        sudo apt-get install -y telnet
    fi
	while true
	do
		if [[ "$count" -gt "$maxtry" ]]; then
			echo "node's mongodb doesn't startup in maximum time,  node ip : $ip"
			return 10
		fi
		isMongoRunning $ip 27017
        if [[ $? -eq 0 ]]; then
          return 0
        else
          echo "node $ip mongodb doesn't startup yet, wait 5 seconds..."
          sleep 5
        fi
        let "count+=1"
   done
}

echo "waiting mongodb startup..."
cmd="$@"
dbstring=$MONGODB_NODES
# split to IP array
array=(${dbstring//,/ })
for i in "${!array[@]}"
do
    echo "${array[i]}"
    nodeip="${array[i]}"
    isMongoReady $nodeip
    if [[ $? -ne 0 ]]; then
    	exit 10
    fi
done

echo "Mongodb is up - executing command: $cmd"
exec $cmd
