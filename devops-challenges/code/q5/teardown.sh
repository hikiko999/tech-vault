#!/bin/bash

minikube kubectl -- delete clusterrolebinding chiefadmin-monitor
minikube kubectl -- delete clusterrole monitor
minikube kubectl -- delete serviceaccount chief-admin