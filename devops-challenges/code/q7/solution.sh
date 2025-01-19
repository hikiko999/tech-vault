#!/bin/bash

echo "Building Docker image --->"
docker build -t mysolution .
echo "Creating SSH Key Pair --->"
mkdir ./.ssh
ssh-keygen -t rsa -b 4096 -f ./.ssh/id_rsa -N ""
chmod 600 ./.ssh/id_rsa ./.ssh/id_rsa.pub
echo "Running Docker container --->"
docker run --rm -d -v ./.ssh/id_rsa.pub:/home/ubuntu/.ssh/authorized_keys -p 8888:80 -p 2222:22 hikiko999/ubuntu-ssh:1.0

# If hosts key checking error
# ssh-keygen -f "/home/suadmin/.ssh/known_hosts" -R "[127.0.0.1]:2222"
echo "Running Ansible --->"
ansible-playbook playbooks/solution.yml
echo "Testing server --->"
curl localhost:8888
echo