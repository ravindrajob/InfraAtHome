# InfraAtHome

Here a simple example of my infrastructure at home, simple and just enought for my need :)

## Why expose through a reverse proxy
The benefits of  reverse proxy is 
- load balancing
- global server load balancing (GSLB)
- caching content and web acceleration for improved performance
- secure SSL encryption, and
- protection from DDoS attacks and related security issues.

In my case i will use this component only for ssl encryption, and control the access by using opensoruce tools like basic authent, Fail2ban, MFA, and ip filtered
Actually i expose only 1 server on 443/80

![alt text](https://ravindrajob.blob.core.windows.net/assets/HL-InfraAtHome.png)

## Why use a local DNS ?
If i use a dns server like google ( 8.8.8.8) i must registred all my local servers. And with my untrust and trust zonal, i need DNS view.
## Why use a DNS and a pi-hole  ?
In my case i need DNS view, but Pi-hole don't implemented this feature.
## Why many docker-compose and not one ?
## Why use a scripts to start all Docker-compose ?
## Why use latest and not a specific version ?
The tag latest is used by default in my examples. In my "production" i use a specific version. I use latest in my DEV environment.
## Why use Gitea and not GitHub ?
Because is "Self-hosted"

# Pre-recquis

### LOKI
```console
cd /usr/libexec/docker/
sudo ln -s docker-runc-current docker-runc 
docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
 ```

#### Check driver installation
```console
docker plugin ls
 ```
| :exclamation:   Be sure you have the last version of docker greater than 17  |
|------------------------------------------------------------------------------|
#### Docker version 
```console
 docker version
 ```
##### upgrade example :
```console
sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux  docker-engine-selinux docker-engine
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce

sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
```
##### REFERENCE : https://docs.docker.com/install/linux/docker-ce/centos/