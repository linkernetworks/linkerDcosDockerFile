#!/bin/bash

#add slave node to mongodb master
addSlaveNode() {
	slaveIP=$1
	echo "add slave: $slaveIP to mongo cluster"
	maxtry=50
	count=0
  while true
	do
		if [[ "$count" -gt "$maxtry" ]]; then
			echo "slave node mongo does not startup in maximum time, will not be added to cluster, slave ip : $slaveIP"
			break
		fi
		mongo "$slaveIP":27017 --eval "quit();"
        if [[ $? -eq 0 ]]; then
          echo "slave mongodb startup successfully, ip is: $slaveIP"
          local cmd="db.auth('$ADMINUSER', '$PASS'); rs.add('$slaveIP'); quit();"
          local newcmd=$cmd
          mongo $ADMINDB --eval "$newcmd"
          break
        else
          echo "slave mongodb doesn't startup yet, wait 10 seconds..."
          sleep 10
        fi
        let "count+=1"
   done
}

startAsMongoSlave() {
  echo "Staring MongoDB as Slave node..."
  /usr/bin/mongod --dbpath /data/db --keyFile /key/mongodb-keyfile --replSet "$ReplSetName" 

}

startAsMongoMaster() {
  echo "Staring MongoDB as Master node..."
  nohup /usr/bin/mongod --dbpath /data/db --keyFile /key/mongodb-keyfile --replSet "$ReplSetName" &
  echo "waiting for mongo starup..."
  # wait until mongo started
  # while ! netstat -alp | grep 27017; do sleep 1; done
  RET=1
  while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MongoDB service startup"
    sleep 2
    mongo $ADMINDB --eval "help" >/dev/null 2>&1
    RET=$?
  done

  echo "Config mongo Cluster..."
  local cmd="db.auth('$ADMINUSER', '$PASS'); rs.initiate(); quit();"
  local newcmd=$cmd
  mongo $ADMINDB --eval "$newcmd"
  
  #using ip address in mongo cluster
  cmd="db.auth('$ADMINUSER', '$PASS'); cfg=rs.conf(); cfg.members[0].host='$currentIP:27017'; rs.reconfig(cfg); quit();"
  newcmd=$cmd
  mongo $ADMINDB --eval "$newcmd" 

  echo "Add other node to MongoDB replSet..."
  for node in ${arr[@]}
  do
     if [[ "$node" != "$currentIP" ]]; then
     	addSlaveNode "$node"
     fi
  done

  sleep 10
  echo "restart mongod as non deamon mode..."
  /usr/bin/mongod --shutdown
  sleep 5
  /usr/bin/mongod --dbpath /data/db --keyFile /key/mongodb-keyfile --replSet "$ReplSetName"
}

createUserPwd() {
	# Start MongoDB
  nohup /usr/bin/mongod --dbpath /data/db &
  # wait until mongo started
  RET=1
  while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MongoDB service startup"
    sleep 2
    mongo $ADMINDB --eval "help" >/dev/null 2>&1
    RET=$?
  done

  echo "Creating mgmt user: rootadmin for repl ..."
  local cmd1="db.createUser({ user: '$ADMINUSER', pwd: '$PASS', roles: [ { role:'$ADMINROLE', db: '$ADMINDB' } ] }); quit();"
  local newcmd1=$cmd1
  mongo $ADMINDB --eval "$newcmd1"

  echo "config system.version.authSchema to 3"
  local cmd="var schema=db.system.version.findOne({'_id' : 'authSchema'}); schema.currentVersion=3; db.system.version.save(schema); quit();"
  local newcmd=$cmd
  mongo $ADMINDB --eval "$newcmd"

  #Create USER
  echo "Creating user: \"$USER\" ..."
  cmd="db.createUser({user:'$USER', pwd:'$PASS', roles: [ { role:'$ROLE', db:'$DB'}]}); quit();"
  newcmd=$cmd
  mongo $DB --eval "$newcmd"

  #Shutdown MongoDb
  /usr/bin/mongod --dbpath /data/db --shutdown

}


USER=${MONGODB_USERNAME:-linker}
PASS=${MONGODB_PASSWORD:-password}
DB=${MONGODB_DB:-linker_dcos}
ADMINDB="admin"
ROLE="dbOwner"
ADMINUSER="rootadmin"
ADMINROLE="root"


#all mongodb cluster node list: 172.17.2.2,172.17.2.3,172.17.2.4
IPs=${MONGODB_NODES}
ReplSetName=${MONGODB_REP_NAME:-linkerSet}
if [[  -z "$IPs" ]]; then
	echo "invalid parameter, no mongodb host ips!"
	exit 10
fi

ifname=${ENNAME:-eth0}
#split IPs by ","
currentIP=`ifconfig $ifname | grep "inet " |cut -d: -f2| awk '{print $2}'`
isMaster=false
masterCount=0
OLD_IFS="$IFS" 
IFS="," 
arr=($IPs) 
IFS="$OLD_IFS" 
for s in ${arr[@]} 
do 
    # echo "$s" 
    if [[ "$s" == "$currentIP" ]]; then
    	if [[ $masterCount -eq 0 ]];then
            isMaster=true
            break
        else
        	startAsMongoSlave
        	break
        fi 
    else   
        echo "not current node ip, will skip!"
    fi

    let "masterCount +=1"
done

#start mongo master node
if  $isMaster; then
	createUserPwd
	startAsMongoMaster
	
fi

# rm -rf /data/.firstrun

