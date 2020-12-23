# cadvisor

Upstream cadvisor does not build for arm64. This does.

## Building

### buildx

Great tool from Docker. Very easy and fast cross-compilation on macOS!

NOTE: Must use a non-docker driver! If you're not in the know, just run:
```bash
docker buildx create --use --name=buildx
docker buildx inspect --bootstrap buildx
```

You should then see the following:
```
Name:   buildx
Driver: docker-container

Nodes:
Name:      buildx0
Endpoint:  unix:///var/run/docker.sock
Status:    running
Platforms: linux/amd64, linux/arm64, linux/riscv64, linux/ppc64le, linux/s390x, linux/386, linux/arm/v7, linux/arm/v6
```

```bash
docker buildx build --push --platform linux/arm64,linux/amd64 --tag jovalle/cadvisor:latest .
```

## Run
```
docker run \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:ro \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --volume=/dev/disk/:/dev/disk:ro \
  --publish=8080:8080 \
  --detach=true \
  --name=cadvisor \
  --privileged \
  --device=/dev/kmsg \
  jovalle/cadvisor:latest
```