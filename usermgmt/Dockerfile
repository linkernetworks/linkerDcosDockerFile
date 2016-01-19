FROM centos:7
MAINTAINER qye@linkernetworks.com

ENV USERMGMT_DIR /usr/local/bin

ENV VERSION 1.0

RUN ln -f -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN yum -y update && \
    yum -y install vim && \
    yum -y install unzip && \
    yum -y install net-tools.x86_64


COPY user_mgmt/usermgmt $USERMGMT_DIR/

COPY user_mgmt/usermgmt.properties $USERMGMT_DIR/

COPY user_mgmt/userPolicy.json $USERMGMT_DIR/

COPY user_mgmt/swagger-ui $USERMGMT_DIR/

ADD entrypoint.sh $USERMGMT_DIR/entrypoint.sh

EXPOSE 10001

RUN chmod 755 $USERMGMT_DIR/usermgmt

RUN chmod 755 $USERMGMT_DIR/entrypoint.sh

VOLUME ["/var/log"]

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

