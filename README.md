## 👋 Welcome to opengist 🚀  

opengist README  
  
  
## Install my system scripts  

```shell
 sudo bash -c "$(curl -q -LSsf "https://github.com/systemmgr/installer/raw/main/install.sh")"
 sudo systemmgr --config && sudo systemmgr install scripts  
```
  
## Automatic install/update  
  
```shell
dockermgr update opengist
```
  
## Install and run container
  
```shell
mkdir -p "$HOME/.local/share/srv/docker/opengist/rootfs"
git clone "https://github.com/dockermgr/opengist" "$HOME/.local/share/CasjaysDev/dockermgr/opengist"
cp -Rfva "$HOME/.local/share/CasjaysDev/dockermgr/opengist/rootfs/." "$HOME/.local/share/srv/docker/opengist/rootfs/"
docker run -d \
--restart always \
--privileged \
--name casjaysdevdocker-opengist \
--hostname opengist \
-e TZ=${TIMEZONE:-America/New_York} \
-v "$HOME/.local/share/srv/docker/casjaysdevdocker-opengist/rootfs/data:/data:z" \
-v "$HOME/.local/share/srv/docker/casjaysdevdocker-opengist/rootfs/config:/config:z" \
-p 80:80 \
-p 2222:22 \
casjaysdevdocker/opengist:latest
```
  
## via docker-compose  
  
```yaml
version: "2"
services:
  ProjectName:
    image: casjaysdevdocker/opengist
    container_name: casjaysdevdocker-opengist
    environment:
      - TZ=America/New_York
      - HOSTNAME=opengist
    volumes:
      - "$HOME/.local/share/srv/docker/casjaysdevdocker-opengist/rootfs/data:/data:z"
      - "$HOME/.local/share/srv/docker/casjaysdevdocker-opengist/rootfs/config:/config:z"
    ports:
      - 80:80
      - 2222:22
    restart: always
```
  
## Get source files  
  
```shell
dockermgr download src casjaysdevdocker/opengist
```
  
OR
  
```shell
git clone "https://github.com/casjaysdevdocker/opengist" "$HOME/Projects/github/casjaysdevdocker/opengist"
```
  
## Build container  
  
```shell
cd "$HOME/Projects/github/casjaysdevdocker/opengist"
buildx 
```
  
## Authors  
  
🤖 casjay: [Github](https://github.com/casjay) 🤖  
⛵ casjaysdevdocker: [Github](https://github.com/casjaysdevdocker) [Docker](https://hub.docker.com/u/casjaysdevdocker) ⛵  
