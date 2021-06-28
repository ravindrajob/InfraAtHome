# Registry
Here a Docker registry for  versioning, storing and distributing my Docker images. 
There are other public registries available online, but for my need, i use a selfhosted registry

## Add your registry if it's insecure :
/etc/docker/daemon.json

{ "insecure-registries":["yourregistryIP:5000"] }

## Example from docker site
```console
$ docker pull ubuntu:16.04
$ docker tag ubuntu:16.04 myregistry.domain.com/my-ubuntu
$ docker push myregistry.domain.com/my-ubuntu
$ docker pull myregistry.domain.com/my-ubuntu
 ```
## CheatSheet

#### List all repositories
```console
curl -X GET https://registry.ravindra-job.com:5000/v2/_catalog
 ```

#### List all tags for a repository
```console
curl -X GET https://registry.ravindra-job.com:5000/v2/ubuntu/tags/list
 ```

#### with authentication 

```console
curl -X GET -u <user>:<pass> https://registry.ravindra-job.com:5000/v2/_catalog
curl -X GET -u <user>:<pass> https://registry.ravindra-job.com:5000/v2/ubuntu/tags/list
 ```