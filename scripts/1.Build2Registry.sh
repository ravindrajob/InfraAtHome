#########################
#     Build images      #
#########################

###################
##### API-GW ####
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