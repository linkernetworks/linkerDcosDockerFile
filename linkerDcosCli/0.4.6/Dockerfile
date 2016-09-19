FROM python:2.7

ENV DCOS_CLI_VERSION 0.4.6

RUN pip install virtualenv
RUN mkdir -p dcos && cd dcos && \
  curl -O https://downloads.dcos.io/dcos-cli/install.sh && \
  bash ./install.sh . http://52.78.100.194 --add-path yes && \
  echo "source ./dcos/bin/env-setup" >> /root/.bashrc

RUN bash -c "source ./dcos/bin/env-setup && dcos config set core.reporting False"

# install jdk7
RUN apt-get update && apt-get install -y openjdk-7-jdk

CMD ["dcos"]
