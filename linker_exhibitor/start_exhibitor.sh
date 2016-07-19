#!/bin/bash

MISSING_VAR_MESSAGE="must be set"
: ${ZOOKEEPERLIST:?$MISSING_VAR_MESSAGE}

# findout local ip, using local ip as server's hostname
if [ -z "$ENNAME" ];then
	ENNAME=eth0
fi
HOSTNAME=`ip addr show $ENNAME|grep "inet.*brd.*$ENNAME"|awk '{print $2}'|awk -F/ '{print $1}'`

# findout servers from ZOOKEEPERLIST
IFS=',' read -r -a ZOOKEEPER_LIST <<< "${ZOOKEEPERLIST}"
STATIC_ENSEMBLE_SIZE=${#ZOOKEEPER_LIST[@]}
STATIC_ENSEMBLE=

# generate default conf
cat <<- EOF > /opt/exhibitor/exhibitor_defaults.conf
# These Exhibitor properties are used to first initialize the config stored in
# an empty shared storage location. Any subsequent invocations of Exhibitor will
# ignore these properties and use the config founded in shared storage
zookeeper-data-directory=/opt/zookeeper/snapshot
zookeeper-install-directory=/opt/zookeeper
zookeeper-log-directory=/opt/zookeeper/transactions
log-index-directory=/opt/zookeeper/transactions
cleanup-period-ms=300000
check-ms=5000
backup-period-ms=600000
client-port=2181
cleanup-max-files=20
backup-max-store-ms=21600000
connect-port=2888
observer-threshold=0
election-port=3888
zoo-cfg-extra=tickTime\=2000&initLimit\=10&syncLimit\=5&quorumListenOnAllIPs\=true&maxClientCnxns\=0&autopurge.snapRetainCount\5&autopurge.purgeInterval\=6
auto-manage-instances-settling-period-ms=0
auto-manage-instances=1
auto-manage-instances-fixed-ensemble-size=${STATIC_ENSEMBLE_SIZE}
EOF

for (( i=0; i<${STATIC_ENSEMBLE_SIZE}; i++));
do
   # do whatever on $i
   STATIC_ENSEMBLE=${i}:${ZOOKEEPER_LIST[$i]%:2888:3888},${STATIC_ENSEMBLE}
done

# removing leading and tailing comma
STATIC_ENSEMBLE=${STATIC_ENSEMBLE%%,}

BACKUP_CONFIG="--configtype=static --staticensemble ${STATIC_ENSEMBLE}"

exec 2>&1

java	-Xbootclasspath/a:${JAVA_HOME}/lib/tools.jar \
	-jar /opt/exhibitor/exhibitor.jar \
	--port 8181 \
	--defaultconfig /opt/exhibitor/exhibitor_defaults.conf \
	${BACKUP_CONFIG} \
	--hostname ${HOSTNAME}
