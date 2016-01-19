# Dockerfile help
Dockerfile for cluster_mgmt in project Linker_Cluster 

## Env

> VERSION 1.0
> Version of this distributed dockerfile.

> CLUSTER_DIR /usr/local/bin
> Path to store clustermgmt binary files and it's dependencies.

## Build

Build docker image with this script.

```sh
./build.sh
```

## Config

**lb.host**
load balancer host

**db.alias**
mongodb run mode

**mongo.product.host**
DO NOT EDIT THIS MANUALLY.
This will be auto-configured by the bash "entrypoint.sh".
An environment variable named MONGODB_NODES needed.

## Run
Run a container in command line.

```sh
docker run -d --name clustermgmt -p 8080:10002 -e MONGODB_NODES=192.168.1.198,192.168.10.91 linkerrepository/linkerdcos_clustermgmt
```
## Marathon

Send request to marathon to start a docker container of this image.

> POST 192.168.10.91:8080/v2/apps

```json
{  
   "id":"/linkerdcos/cluster/clustermgmt",
   "instances":1,
   "cpus":0.5,
   "mem":512,
   "env":{
       "MONGODB_NODES":"192.168.5.169,192.168.5.160"
   },
   "container":{  
      "type":"DOCKER",
      "docker":{  
         "image":"linkerrepository/linkerdcos_clustermgmt:latest",
         "network":"BRIDGE",
         "portMappings":[  
            {  
               "containerPort":10002,
               "hostPort":10002,
               "servicePort":10002,
               "protocol":"tcp"
            }
         ],
         "volumes":[  
            {  
               "containerPath":"/usr/local/bin",
               "hostPath":"/usr/local/bin",
               "mode":"RW"
            }
         ],
         "privileged":true,
         "forcePullImage":false
      }
   }
}
```
