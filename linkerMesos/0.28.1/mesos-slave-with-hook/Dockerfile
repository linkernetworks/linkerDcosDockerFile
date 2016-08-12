FROM linkerrepository/mesos:0.28.1
MAINTAINER ychen <ychen@linkernetworks.com>

# install docker using default installation script
RUN curl -sSL https://s3-ap-southeast-1.amazonaws.com/docker-engine/default/docker-install.sh | sh -

#RUN systemctl stop docker.service && systemctl disable docker.service

RUN mv /lib/libmesos-0.28.1.so /lib/libmesos-0.28.1.so.old && \
	mv /lib/libmesos.la /lib/libmesos.la.old && \
	curl -o /lib/libmesos-0.28.1.so -sSL https://s3-ap-southeast-1.amazonaws.com/linkerdcos/mesos-slave/libmesos-0.28.1.so && \
	curl -o /lib/libmesos.la -sSL https://s3-ap-southeast-1.amazonaws.com/linkerdcos/mesos-slave/libmesos.la && \
	curl -o /lib/mesos/modules/libpostlaunchdockerhook-0.28.1.so -sSL https://s3-ap-southeast-1.amazonaws.com/linkerdcos/mesos-slave/libpostlaunchdockerhook-0.28.1.so && \
	curl -o /lib/mesos/modules/libpostlaunchdockerhook.la -sSL https://s3-ap-southeast-1.amazonaws.com/linkerdcos/mesos-slave/libpostlaunchdockerhook.la && \
	ln -s /lib/mesos/modules/libpostlaunchdockerhook-0.28.1.so /lib/mesos/modules/libpostlaunchdockerhook.so && \
	chmod +x /lib/*.so && \
	chmod +x /lib/mesos/modules/*.so

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

