How to run cadvisor in docker:
command: sudo docker run   --volume=/:/rootfs:ro   --volume=/var/run:/var/run:rw   --volume=/sys:/sys:ro   --volume=/var/lib/docker/:/var/lib/docker:ro --volume=/cgroup:/cgroup:ro   --publish=10000:10000   --detach=true --privileged=true   --name=cadvisor  linker_cadvisor

