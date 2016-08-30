FROM centos:7


# Install packages
RUN yum install -y unzip wget curl net-tools

# Install EPEL Repository
RUN yum install -y epel-release

# Clean CentOS 7
RUN yum clean all

# Install MongoDB
RUN echo -e "[mongodb]\nname=MongoDB Repository\nbaseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/3.0/`uname -m`/\ngpgcheck=0\nenabled=1" > /etc/yum.repos.d/mongodb.repo
RUN yum install -y mongodb-org

ADD scripts /scripts
RUN chmod -R 755 /scripts

RUN mkdir /key
ADD mongodb-keyfile /key/
RUN chmod 600 /key/mongodb-keyfile

VOLUME ["/data"]


EXPOSE 27017

ENTRYPOINT ["/scripts/run.sh"]
CMD [""]

