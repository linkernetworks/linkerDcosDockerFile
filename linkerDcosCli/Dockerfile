FROM java:openjdk-7-jdk

ENV HOME /home/ubuntu

#RUN useradd -b /home ubuntu

COPY .dcos ${HOME}/.dcos

COPY dcos ${HOME}/dcos

#RUN chown -R root:root /root

RUN apt-get update && \
    apt-get install -y curl git python2.7 

#RUN chown -R ubuntu:ubuntu ${HOME}

RUN curl -sSL https://bootstrap.pypa.io/get-pip.py | python - && pip install virtualenv

RUN apt-get install -y telnet unzip

ENV PATH $PATH:${HOME}/dcos/bin

WORKDIR ${HOME}

#USER ubuntu

