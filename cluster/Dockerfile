FROM centos:7
MAINTAINER Yifa Zhang <yzhang3@linkernetworks.com>

ENV VERSION 1.0
ENV CLUSTER_DIR /linker
WORKDIR $CLUSTER_DIR
EXPOSE 10002
VOLUME ["/var/log"]

RUN ln -f -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY entrypoint.sh $CLUSTER_DIR/entrypoint.sh
COPY clustermgmt/* $CLUSTER_DIR/

RUN chmod +x "$CLUSTER_DIR"/cluster_mgmt \
	"$CLUSTER_DIR"/entrypoint.sh

ENTRYPOINT ["/linker/entrypoint.sh"]
