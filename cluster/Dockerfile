FROM centos:7
MAINTAINER yzhang3@linkernetworks.com

ENV VERSION 1.0
ENV CLUSTER_DIR /usr/local/bin

RUN ln -f -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY clustermgmt/cluster_mgmt $CLUSTER_DIR/
COPY clustermgmt/cluster_mgmt_policy.json $CLUSTER_DIR/
COPY clustermgmt/cluster_mgmt.properties $CLUSTER_DIR/
COPY clustermgmt/swagger-ui $CLUSTER_DIR/

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x $CLUSTER_DIR/cluster_mgmt
RUN chmod +x /entrypoint.sh

EXPOSE 10002

VOLUME ["/var/log"]

ENTRYPOINT ["/entrypoint.sh"]

# CMD ["/usr/local/bin/cluster_mgmt","-config=/usr/local/bin/cluster_mgmt.properties"]
