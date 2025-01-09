#!/bin/bash

# RUN WITH SUDO TO CREATE USER AND GROUP

echo "Extracteding files"
echo "---"
mkdir extracted
tar -xvzf ./backup.tar.gz -C ./extracted 
chown 0644 ./extracted/file*
chown 0755 ./extracted/dir*
echo

username=anonymous
groupname=no-team

# This redirects standard output and stderror to /dev/null
if ! id -u $username > /dev/null 2>&1; then
    useradd anonymous
    echo "Created user \"$username\""
fi

if ! getent group $groupname > /dev/null 2>&1; then
    groupadd $groupname
    echo "Created user \"$groupname\""
fi

if [ ! -d "./tmp" ]; then
    echo "Creating tmp folder"
    mkdir ./tmp
fi
echo

echo "Creating new archive in 'tmp' for files and directories"
echo "---"
tar -czvf ./tmp/fixed-archive.tar.gz ./extracted/*
echo "Listing files in created archive"
echo 
echo "..."
tar -tzvf ./tmp/fixed-archive.tar.gz

echo "Finished running"