#!/bin/bash

read -p "PROJECT ID : " project_id
gcloud container clusters get-credentials k8s-cluster --zone us-west1-a --project $project_id

if [ $1 = "build" ]; then
  echo -e '\nCreating Namespaces...'
  kubectl apply -f kubernetes/guestbook/components/namespaces.yaml

  echo -e "\nBuilding NGINX Load Balancer..."
  kubectl apply -f kubernetes/guestbook/components/nginx-ingress.yaml
  sleep 10

  for namespace in {'staging','production'}
  do
    echo -e "\nDeploying application in ${namespace}..."
    kubectl apply -f kubernetes/guestbook/ -n $namespace
    echo "Application deployed in ${namespace}, sleeping for 30 seconds..."
    sleep 30
  done

  # Output
  kubectl get all -n staging
  kubectl get all -n production
elif [ $1 = "destroy" ]; then
  for namespace in {'staging','production'}
  do
    echo -e "\nDestroying application in ${namespace}..."
    kubectl delete -f kubernetes/guestbook/ -n $namespace
    echo "Application destroyed in ${namespace}, sleeping for 30 seconds..."
    sleep 30
  done

  echo -e "\nDestroying NGINX Load Balancer..."
  kubectl delete -f kubernetes/guestbook/components/nginx-ingress.yaml
  sleep 10

  echo -e '\nDeleting Namespaces...'
  kubectl delete -f kubernetes/guestbook/components/namespaces.yaml
else
  echo 'Wrong argument'
  exit 1
fi
