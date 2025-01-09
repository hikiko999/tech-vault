#!/bin/bash

minikube kubectl -- create cronjob task --image=antrea/toolbox --schedule="*/1 * * * *" -- curl -ks https://httpbin.org/get

# there is no official "toolbox" image
# https://api.cyber-widget.com/refresh is unreachable