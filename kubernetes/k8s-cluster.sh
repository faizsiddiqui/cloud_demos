#!/bin/bash

export GOOGLE_APPLICATION_CREDENTIALS='kubernetes/terraform/creds/account.json'
gcloud auth activate-service-account --key-file $GOOGLE_APPLICATION_CREDENTIALS

# Kubernetes Cluster
if [ "$1" = "build" ]; then
  echo -e "\nBuilding K8s Cluster..."
  cd kubernetes/terraform && terraform init && terraform validate && terraform plan && terraform apply -auto-approve
elif [ "$1" = "destroy" ]; then
  echo -e "\nDestroying K8s Cluster..."
  cd kubernetes/terraform && terraform destroy -auto-approve
else
  echo 'Wrong argument'
  exit 1
fi
