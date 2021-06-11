#!/bin/bash

######################################################################################
# Titre:  Supression entière
# Auteur: Ravindra JOB
# Source: https://github.com/ravindrajob/
# Update: 09/11/2018 [RJ]
# Attention ce script supprime toutes les images, container, volumes, réseaux ....
######################################################################################

# Stop all containers
docker stop `docker ps -qa`

# Remove all containers
docker rm `docker ps -qa`

# Remove all images
docker rmi -f `docker images -qa `

# Remove all volumes
#docker volume rm $(docker volume ls -qf)
docker volume rm $(docker volume ls -q)

# Remove all networks
docker network rm `docker network ls -q`

# Your installation should now be all fresh and clean.

# The following commands should not output any items:
# docker ps -a
# docker images -a 
# docker volume ls

# The following command show only show the default networks:
# docker network ls
