#!/bin/bash

# RUN WITH SUDO TO DELETE USERS AND GROUPS
# Removes/reverts changes from runscript.sh

username=anonymous
groupname=no-team

echo "Checking created users and groups"
echo "..."

# This redirects standard output and stderror to /dev/null
if id -u $username > /dev/null 2>&1; then
    echo "Deleting user \"anonymous\""
    userdel $username
fi

if getent group $groupname > /dev/null 2>&1; then
    echo "Deleting group \"no-team\""
    groupdel $groupname
fi
echo "..."

echo "Deleting folders"

if [ -d "./tmp" ]; then
    rm -r ./tmp
fi

if [ -d "./extracted" ]; then
    rm -r ./extracted
fi

echo "Finished cleanup"