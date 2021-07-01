# InfraAtHome
Here a simple example of my infrastructure at home, simple and just enought for my need :)

![alt text](https://ravindrajob.blob.core.windows.net/assets/HL-InfraAtHome.png)

# FAQ
## Why expose through a reverse proxy ?
The benefits of  reverse proxy is 
- load balancing
- caching content and web acceleration for improved performance
- secure SSL encryption
- protection from DDoS attacks and related security issues. (in comming Naxsi or ModSecurity )

In my case i will use this component only for ssl encryption, and control the access by using opensoruce tools like basic authent, Fail2ban, MFA, and ip filtered
Actually i expose only 1 server on 443/80

## Why use a local DNS ?
If i use a dns server like google (8.8.8.8) i must registred all my local servers. And with my untrust and trust zonal, i need DNS view.
## Why use a DNS and a pi-hole ?
In my case i need DNS view, but Pi-hole don't implemented this feature.
![alt text](https://ravindrajob.blob.core.windows.net/assets/piHole.png)
source: https://github.com/pi-hole/pi-hole

## Why use trivy ?
Trivy is a simple and comprehensive vulnerability scanner for containers. Very easy to use. All need for scanning specify target such as an image name of the container.
![alt text](https://github.com/aquasecurity/trivy/blob/main/docs/imgs/overview.png)
See more: https://github.com/aquasecurity/trivy

## Why many docker-compose and not one ?
* In progress 
## Why use a scripts to start all Docker-compose ?
* In progress 
## Why use latest and not a specific version ?
The tag latest is used by default in my examples. In my "production" i use a specific version. I use latest in my DEV environment.
## Why use Gitea and not GitHub ?
Because is "Self-hosted"

## Why use a local registry and not a public registry ?
In certain scenarios, you might not want to push your images outside of your network. In my case you can set up a local registry using the open source software project Distribution.

# Prerequisites

### For Pi-hole
Use this command to get the admin password
```console
docker logs pihole | grep random
 ```
Use this dashboard for grafana :
https://grafana.com/grafana/dashboards/10176


### For LOKI
"Loki - Cloud Native Log Aggregation by Grafana"
![alt text](https://ravindrajob.blob.core.windows.net/assets/loki.png)
##### Install
```console
cd /usr/libexec/docker/
sudo ln -s docker-runc-current docker-runc 
docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
 ```
##### Upgrade
```console
docker plugin disable loki --force
docker plugin upgrade loki grafana/loki-docker-driver:latest --grant-all-permissions
docker plugin enable loki
systemctl restart docker
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


##### Put at the top of your docker-compose.yml
```console
version: '3.8'
# logger driver - change this driver to ship all container logs to a different location
x-logging:
    &MyDocker-logging
    driver: loki
    options:
      loki-url: http://localhost:3100/loki/api/v1/push

 ```
and 
   logging: *MyDocker-logging
in each containers

Like 
```console
...
  alertmanager:
    image: prom/alertmanager:v0.22.1
    logging: *MyDocker-logging
    ports:
        - 9093:9093
    volumes:
        - /home/ravindra/docker/alertmanager/:/etc/alertmanager/
    command:
        - '--config.file=/etc/alertmanager/alertmanager.yml'
        - '--storage.path=/alertmanager'
    restart: unless-stopped

  grafana:
    image: grafana/grafana:8.0.2-ubuntu
    user: "1000:1000"
    logging: *MyDocker-logging
...

 ```


If you have some timeout when you up your docker-compose use this ENV value :

```console
export DOCKER_CLIENT_TIMEOUT=120
export COMPOSE_HTTP_TIMEOUT=120
 ```


##### REFERENCE : https://docs.docker.com/install/linux/docker-ce/centos/


##### put the following lines in your nginx config
##### /etc/nginx/nginx.conf
```console
log_format json_analytics escape=json '{'
                            '"msec": "$msec", ' # request unixtime in seconds with a milliseconds resolution
                            '"connection": "$connection", ' # connection serial number
                            '"connection_requests": "$connection_requests", ' # number of requests made in connection
                    '"pid": "$pid", ' # process pid
                    '"request_id": "$request_id", ' # the unique request id
                    '"request_length": "$request_length", ' # request length (including headers and body)
                    '"remote_addr": "$remote_addr", ' # client IP
                    '"remote_user": "$remote_user", ' # client HTTP username
                    '"remote_port": "$remote_port", ' # client port
                    '"time_local": "$time_local", '
                    '"time_iso8601": "$time_iso8601", ' # local time in the ISO 8601 standard format
                    '"request": "$request", ' # full path no arguments if the request
                    '"request_uri": "$request_uri", ' # full path and arguments if the request
                    '"args": "$args", ' # args
                    '"status": "$status", ' # response status code
                    '"body_bytes_sent": "$body_bytes_sent", ' # the number of body bytes exclude headers sent to a client
                    '"bytes_sent": "$bytes_sent", ' # the number of bytes sent to a client
                    '"http_referer": "$http_referer", ' # HTTP referer
                    '"http_user_agent": "$http_user_agent", ' # user agent
                    '"http_x_forwarded_for": "$http_x_forwarded_for", ' # http_x_forwarded_for
                    '"http_host": "$http_host", ' # the request Host: header
                    '"server_name": "$server_name", ' # the name of the vhost serving the request
                    '"request_time": "$request_time", ' # request processing time in seconds with msec resolution
                    '"upstream": "$upstream_addr", ' # upstream backend server for proxied requests
                    '"upstream_connect_time": "$upstream_connect_time", ' # upstream handshake time incl. TLS
                    '"upstream_header_time": "$upstream_header_time", ' # time spent receiving upstream headers
                    '"upstream_response_time": "$upstream_response_time", ' # time spend receiving upstream body
                    '"upstream_response_length": "$upstream_response_length", ' # upstream response length
                    '"upstream_cache_status": "$upstream_cache_status", ' # cache HIT/MISS where applicable
                    '"ssl_protocol": "$ssl_protocol", ' # TLS protocol
                    '"ssl_cipher": "$ssl_cipher", ' # TLS cipher
                    '"scheme": "$scheme", ' # http or https
                    '"request_method": "$request_method", ' # request method
                    '"server_protocol": "$server_protocol", ' # request protocol, like HTTP/1.1 or HTTP/2.0
                    '"pipe": "$pipe", ' # "p" if request was pipelined, "." otherwise
                    '"gzip_ratio": "$gzip_ratio", '
                    '"http_cf_ray": "$http_cf_ray",'
                    '"geoip_country_code": "$geoip_country_code"'
                    '}';

 access_log /var/log/nginx/json_access.log json_analytics;

```
### For PlantFlora
You can use this exporter and build a similar dashbaord with this 
![alt text](https://ravindrajob.blob.core.windows.net/assets/N5-Miflora.png)