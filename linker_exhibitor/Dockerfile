FROM maven:3.3.9-jdk-8

# set up Environments
ENV \
	ZK_RELEASE="http://www.apache.org/dist/zookeeper/zookeeper-3.4.6/zookeeper-3.4.6.tar.gz" 

RUN \
	# install zookeeper
	curl -Lo /tmp/zookeeper.tgz $ZK_RELEASE \
	&& mkdir -p /opt/zookeeper/transactions /opt/zookeeper/snapshot \
	&& tar -xzf /tmp/zookeeper.tgz -C /opt/zookeeper --strip=1 \
	&& rm /tmp/zookeeper.tgz \

	# install exhibitor
	&& mkdir -p /opt/exhibitor 
#	&& curl -Lo /opt/exhibitor/pom.xml $EXHIBITOR_POM \
#	&& mvn -f /opt/exhibitor/pom.xml package \
#	&& ln -s /opt/exhibitor/target/exhibitor*jar /opt/exhibitor/exhibitor.jar 

# add the wrapper script to setup configs and exec exhibitor
ADD exhibitor.jar /opt/exhibitor/exhibitor.jar
ADD start_exhibitor.sh /opt/exhibitor/start_exhibitor.sh

USER root
WORKDIR /opt/exhibitor
EXPOSE 2181 2888 3888 8181

ENTRYPOINT ["bash", "-ex", "/opt/exhibitor/start_exhibitor.sh"]
