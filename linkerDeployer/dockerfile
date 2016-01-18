From schmunk42/docker-toolbox

MAINTAINER linker

WORKDIR /linker

#COPY the bin file 
ADD dcos_deploy /linker/dcos_deploy
RUN chmod 755 /linker/dcos_deploy
ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

#COPY the config file 
ADD dns-config.json /linker/config/dns-config.json
ADD docker-compose.yml /linker/config/docker-compose.yml
ADD dcos_deploy.properties /linker/config/dcos_deploy.properties
ADD docker-machine /opt/local/bin/docker-machine
RUN chmod +x /opt/local/bin/docker-machine

#COPY the key file 
ADD mongodb-keyfile /linker/key/mongodb-keyfile
ADD id_rsa.pub /linker/key/id_rsa.pub
ADD id_rsa /root/.ssh/id_rsa
RUN chmod 600 /linker/key/mongodb-keyfile && \
	cp /root/.ssh/id_rsa /linker/key/id_rsa

#COPY the Marathon File
ADD marathon-dnslb.json /linker/marathon/marathon-dnslb.json
ADD marathon-dashboard.json /linker/marathon/marathon-dashboard.json
ADD marathon-linkercomponents.json /linker/marathon/marathon-linkercomponents.json
ADD copy-ssh-id.sh /linker/copy-ssh-id.sh
RUN apt-get -y install expect && \
	chmod 755 /linker/copy-ssh-id.sh

EXPOSE 10003

#Expose the config and log folder
VOLUME ["/linker/docker","/linker/config","/linker/log","/linker/marathon"]

#ENTRYPOINT ["/linker/dcos_deploy"]

#CMD ["-config=/linker/config/dcos_deploy.properties", "2>&1"]

ENTRYPOINT ["/bin/bash"]
CMD ["/entrypoint.sh"]
