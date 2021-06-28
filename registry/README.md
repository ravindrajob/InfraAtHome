# Registry
Here a Docker registry for  versioning, storing and distributing my Docker images. 
There are other public registries available online, but for my need, i use a selfhosted registry

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