# linkerWebConsole
This sub repo contains Dockerfile, golang binaries and config files for container **linkerrepository/linker_webconsole**, 
which provides web shell support for Linker DCOS.

# Compose
The docker compose configure is in [docker-compose-user.yml][3]

# ENV
Required environment variables are listed below.

**SWARW_ENDPOINTS**: Comma separated endpint of swarm master.
Example:
SWARW_ENDPOINTS=52.78.88.104:3376,52.78.18.255:1234

# Volume
No cert file was copied to the container, mount a directory containning **ca.pem** **cert.pem** **key.pem** 
from host to **/usr/local/bin/certs** in container when start a new one.

Example:
```sh
docker run -d -p 8080:10022 -v /linker/docker/sysadmin/cluster3/certs:/usr/local/bin/certs linkerrepository/linker_webconsole
```

# Related projects
[LinkerNetworks/gotty][1]: Linker GoTTY is a simple command line tool that turns remote-docker-exec into web applications.

[LinkerNetworks/remote-docker-exec][2]: Connect to docker swarm or docker daemon over TLS,
and run command inside a docker container. Act as a remote docker exec.

[1]:https://github.com/LinkerNetworks/gotty
[2]:https://github.com/LinkerNetworks/remote-docker-exec
[3]:https://github.com/LinkerNetworks/linkerDcosDockerFile/blob/master/linkerDeployer/linker/config/docker-compose-user.yml
