#!/bin/bash

# Reverts changes

show_help(){
    echo "teardown script -> reverts changes"
    echo "---"
    echo "$0 1 - to show config view after"
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_help
    exit 0
fi

minikube kubectl -- config use-context minikube

minikube kubectl -- config unset contexts.operator
minikube kubectl -- config unset users.operator

if [ -f "./request.csr" ]; then
    rm ./request.csr
    echo "Deleted request.csr"
fi

if [ -f "./security.crt" ]; then
    rm ./security.crt
    echo "Deleted security.crt"
fi

if [ -f "./secrecy.key" ]; then
    rm ./secrecy.key
    echo "Deleted secrecy.key"
fi

if [[ "$1" == "1" ]]; then
    echo
    echo "Configuration:"
    minikube kubectl -- config view
fi

echo "Changes reverted"