#!/bin/bash

# not used in favor of yaml config files
# minikube kubectl -- create serviceaccount chief-admin
# minikube kubectl -- create clusterrole monitor --verb=* --resource=*

minikube kubectl -- apply -f ./serviceaccount.yml
echo "---"
minikube kubectl -- describe serviceaccount chief-admin
echo
minikube kubectl -- apply -f ./clusterrole.yml
echo "---"
minikube kubectl -- describe clusterrole monitor
echo
minikube kubectl -- apply -f ./clusterrole-binding.yml
echo "---"
minikube kubectl -- describe clusterrolebinding chiefadmin-monitor

minikube kubectl -- config view