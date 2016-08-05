#!/bin/bash

newline="mongod.product.uri=mongodb:\/\/"

string=$MONGODB_NODES

# split to IP array
array=(${string//,/ })
for i in "${!array[@]}"
do
    echo "${array[i]}"
    item="${array[i]}:27017,"
    echo "$item"
    newline=$newline$item
    echo $newline
done

# replace last ,
newline=${newline::-1}

echo "Final newline"
echo $newline

# replace line
# oldline
# mongod.product.uri=...
# newline
# $newline

sed -i "s/mongod\.product\.uri=.*/${newline}/" /linker/usermgmt.properties

tail /linker/usermgmt.properties

/linker/usermgmt --config=/linker/usermgmt.properties 
