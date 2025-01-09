#!/bin/bash

# SSL Certificates Junior

VALUE_A=""

# playing around with arguments
# ':' -> expecting value
while getopts "a:h" opt; do
  case $opt in
    a)
      VALUE_A=$OPTARG
      ;;
    h)
      echo "Usage: $0 [-a value]"
      echo "  -a 1   to enable showing configuration after"
      exit 0
      ;;
    # getopts only handle single characters
    # help) 
    #   echo "Usage: $0 [-a value]"
    #   echo "  -a 1   to enable showing configuration after"
    #   exit 0
    #   ;;
    \?)
      echo "Usage: $0 [-a value]"
      echo "  -a 1   to enable showing configuration after"
      exit 1
      ;;
  esac
done

# show_help(){
#     echo "teardown script -> reverts changes"
#     echo "---"
#     echo "$0 1 - to show config view after"
# }

openssl genpkey -algorithm RSA -out secrecy.key -pkeyopt rsa_keygen_bits:2048
openssl req -new -key secrecy.key -out request.csr -subj "/CN=example.com"
openssl x509 -req -in request.csr -signkey secrecy.key -out security.crt -days 365
minikube kubectl -- config set-credentials operator --client-certificate=./security.crt --client-key=./secrecy.key
minikube kubectl -- config set-context operator --cluster=cluster-name --namespace=default --user=operator
# minikube kubectl -- config view
minikube kubectl -- config use-context operator

# if [[ "$1" == "1" ]]; then
#     echo
#     echo "Configuration:"
#     minikube kubectl -- config view
# fi

# '-' -> Checks non-empty
if [ -n "$VALUE_A" ]; then
    echo
    echo "Configuration:"
    minikube kubectl -- config view
fi