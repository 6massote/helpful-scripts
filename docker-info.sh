#!/bin/bash

if ! which docker; then
    echo '[ERROR] Docker not installed.\n';
    exit 1;
fi

echo "Docker count infos: "
echo "    All images: $(docker images -q | grep -c -e .)"
echo "    Dangling images: $(docker images -q -f 'dangling=true' | grep -c -e .)"
echo "    Images with <none>: $(docker images | grep '<none>' | tr -s ' ' | cut -d ' ' -f 3 | grep -c -e .)"
echo "    All containers: $(docker ps -q -f 'status=exited' | grep -c -e .)"
