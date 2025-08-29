```yaml
---
services:
  crealityprint:
    image: lscr.io/linuxserver/crealityprint:latest
    container_name: crealityprint
    security_opt:
      - seccomp:unconfined #optional
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
      - PASSWORD= #optional
      - CLI_ARGS= #optional
    volumes:
      - /path/to/crealityprint/config:/config
    ports:
      - 8080:8080
      - 8181:8181
    restart: unless-stopped
```

### docker cli ([click here for more info](https://docs.docker.com/engine/reference/commandline/cli/))

```bash
docker run -d \
  --name=crealityprint \
  --security-opt seccomp=unconfined `#optional` \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e PASSWORD= `#optional` \
  -e CLI_ARGS= `#optional` \
  -p 8080:8080 \
  -p 8181:8181 \
  -v /path/to/crealityprint/config:/config \
  --restart unless-stopped \
  lscr.io/linuxserver/crealityprint:latest
```
