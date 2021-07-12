#########################
#     Build images      #
#########################

########################
# Update Docker Config #
########################

cat > /etc/docker/daemon.json << EOF
{
  "log-driver": "loki",
  "log-opts": {
    "loki-url": "http://127.0.0.1:3100/loki/api/v1/push",
    "max-size": "50m",
    "max-file": "10"
  },
  "registry-mirrors": ["yourregistryIP:5000"]
}
EOF

#################
##### API-GW ####
#################

versionapigw="v0.02"

#---> BUILD
docker build -t apigw:$versionapigw /home/ravindra/docker/api-gw/
# docker rmi api-gw:v0.01

#---> TAG
docker tag apigw:$versionapigw registry.ravindra-job.com:5000/apigw:$versionapigw

#---> PUSH
docker push registry.ravindra-job.com:5000/apigw:$versionapigw

#docker images # show all images
#docker rmi myimage # remove image
