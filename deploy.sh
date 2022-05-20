#!/bin/bash

IMAGE_NAME=docker.io/stinkycyborg/lbg-api-image
CONTAINER_NAME=lbg-api-container

# build image
docker rmi -f ${IMAGE_NAME}
docker build -t ${IMAGE_NAME} .

# push to DockerHub
docker push ${IMAGE_NAME}

# run container from image
docker rm -f ${CONTAINER_NAME}
docker run -d -p 80:4000 --name ${CONTAINER_NAME} ${IMAGE_NAME}
docker system prune -f




