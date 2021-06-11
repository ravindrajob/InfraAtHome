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