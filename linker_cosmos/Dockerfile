FROM java:openjdk-8-jdk-alpine

RUN mkdir -p /linker /var/lib/cosmos
WORKDIR /linker
ADD ./cosmos.jar /linker/

EXPOSE 7070

CMD ["java","-Xmx2G","-jar","/linker/cosmos.jar"]
