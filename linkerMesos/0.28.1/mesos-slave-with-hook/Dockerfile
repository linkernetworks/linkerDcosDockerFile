FROM linkerrepository/mesos:0.28.1
MAINTAINER ychen <ychen@linkernetworks.com>

# install docker using default installation script
RUN curl -sSL https://s3-ap-southeast-1.amazonaws.com/docker-engine/default/docker-install.sh | sh -

#RUN systemctl stop docker.service && systemctl disable docker.service
RUN apt-get install curl -y && apt-get install libcurl3-nss -y

RUN mv /usr/lib/libmesos-0.28.1.so /usr/lib/libmesos-0.28.1.so.old && \
	mv /usr/lib/libmesos.la /usr/lib/libmesos.la.old && \
	curl -o /usr/lib/libmesos-0.28.1.so -sSL https://s3-ap-southeast-1.amazonaws.com/linkerdcos/mesos-slave/libmesos-0.28.1.so && \
	curl -o /usr/lib/libmesos.la -sSL https://s3-ap-southeast-1.amazonaws.com/linkerdcos/mesos-slave/libmesos.la && \
	curl -o /usr/lib/mesos/modules/libpostlaunchdockerhook-0.28.1.so -sSL https://s3-ap-southeast-1.amazonaws.com/linkerdcos/mesos-slave/libpostlaunchdockerhook-0.28.1.so && \
	curl -o /usr/lib/mesos/modules/libpostlaunchdockerhook.la -sSL https://s3-ap-southeast-1.amazonaws.com/linkerdcos/mesos-slave/libpostlaunchdockerhook.la && \
	ln -s /usr/lib/mesos/modules/libpostlaunchdockerhook-0.28.1.so /usr/lib/mesos/modules/libpostlaunchdockerhook.so && \
	chmod +x /usr/lib/*.so && \
	chmod +x /usr/lib/mesos/modules/*.so && \
	chmod +x /usr/lib/*.la && \
	chmod +x /usr/lib/mesos/modules/*.la

ADD post_launch_docker_hook.json /usr/local/bin/post_launch_docker_hook.json
ADD linkerconfig /usr/local/bin/linkerconfig

RUN chmod +x /usr/local/bin/linkerconfig

ENV MESOS_MODULES file:///usr/local/bin/post_launch_docker_hook.json
ENV MESOS_HOOKS org_apache_mesos_PostLaunchDockerHook

EXPOSE 5051

ENV MESOS_CONTAINERIZERS docker,mesos
ENV MESOS_LOG_DIR /var/log/mesos

ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

VOLUME ["/sys/fs/cgroup", "/var/run/docker.sock", "/tmp", "/opt/mesosphere", "/var/log/mesos"]

CMD ["/entrypoint.sh"]

