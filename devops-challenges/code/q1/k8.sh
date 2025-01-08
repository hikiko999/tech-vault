#!/bin/bash

show_help() {
    echo
    echo "Script for creating k8 deployment"
    echo "---"
    echo "$0 1 - show created resources after"
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi

show_resources=$1

# Namespace
minikube kubectl -- create namespace cyberco
# Deployment
minikube kubectl -- create deployment cache-db --image=redis:buster --port=6379 --namespace=cyberco
# Replicas
minikube kubectl -- scale deployment cache-db --replicas=2 --namespace=cyberco
echo "Finished creating resources"

if [[ "$show_resources" == "1" ]]; then
    minikube kubectl -- get all -n cyberco
fi