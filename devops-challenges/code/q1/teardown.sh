#!/bin/bash

if minikube kubectl -- get all -n cyberco | grep -q "cache-db"; then
    # Delete all resources
    minikube kubectl -- delete all --all -n cyberco
    # Delete namespace
    minikube kubectl -- delete namespace cyberco
    echo "Finished cleaning up"
else
    echo "No resources detected"
fi