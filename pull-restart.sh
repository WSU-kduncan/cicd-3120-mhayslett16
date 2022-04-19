#!/bin/bash

# pull docker image
#docker pull mhayslett16/project5_repo:latest
# kill old running container (to clear host port) 
#docker kill*

docker stop cheese
docker system prune -f

docker pull mhayslett16/project5_repo:latest
# run new image
docker run -d --name cheese --rm -p 8080:80 mhayslett16/project5_repo:latest
