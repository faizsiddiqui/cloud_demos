#!/bin/bash

# NOTICE :: We are building Image because of a minor bug in the actual/original image

read -p "PROJECT ID : " project_id

# Rebuild Frontend Image
echo -e "\nBuilding Guestbook Image..."
docker build -t gb-frontend:v5 kubernetes/guestbook/php-redis/
docker image ls gb-frontend

# Push images to GCR
echo -e "\nPushing Image to GCR..."
docker tag gb-frontend:v5 gcr.io/$project_id/gb-frontend:v5
gcloud auth configure-docker
docker push gcr.io/$project_id/gb-frontend:v5
gcloud container images list-tags gcr.io/$project_id/gb-frontend # We need to mark it public from console
