#!/bin/bash

createUserPwd() {
	# Start MongoDB
  nohup /usr/bin/mongod --dbpath /data/db --nojournal &
  # wait until mongo started
  RET=1
  while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MongoDB service startup"
    sleep 2
    mongo $ADMINDB --eval "help" >/dev/null 2>&1
    RET=$?
  done

  echo "config system.version.authSchema to 3"
  local cmd="var schema=db.system.version.findOne({'_id' : 'authSchema'}); schema.currentVersion=3; db.system.version.save(schema); quit();"
  local newcmd=$cmd
  mongo $ADMINDB --eval "$newcmd"

  #Create USER
  echo "Start to check whether the user is exist ..."
  temp=$(mongo admin --eval "db.system.users.findOne({'user': '$USER','db': '$DB'},{'_id':1})" | tail -n 1)
  echo $temp
  check="null"
  if [ "$temp" = "$check" ]
  then echo "User is not exist, start to creating user: \"$USER\" ..."
    cmd="db.createUser({user:'$USER', pwd:'$PASS', roles: [ { role:'$ROLE', db:'$DB'}]}); quit();"
    newcmd=$cmd
    mongo $DB --eval "$newcmd"
  else echo "user has already exist"
  fi

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

echo "create user and db for mongo"
createUserPwd
sleep 2
echo "start mongodb......"
/usr/bin/mongod  --auth --dbpath /data/db 
