#!/bin/bash

read -p "PROJECT ID : " project_id
gcloud container clusters get-credentials k8s-cluster --zone us-west1-a --project $project_id

if [ "$1" = "build" ]; then
  echo -e "\nBuilding Stress Machine..."
  kubectl apply -f kubernetes/guestbook/stress-generator/
  sleep 5

  # Watch the show
  watch -d -n 2 "kubectl describe hpa pod-scaler -n production"
elif [ "$1" = "destroy" ]; then
  echo -e "\nDestroying Stress Machine..."
  kubectl delete -f kubernetes/guestbook/stress-generator/
else
  echo 'Wrong argument'
  exit 1
fi
