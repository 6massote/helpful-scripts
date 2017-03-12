#!/bin/bash

if ! which docker; then
    echo '[ERROR] Docker not installed.\n';
    exit 1;
fi

if [[ $# -eq 0 ]]; then
    echo '[ERROR] Inputs required. Options: all, none, dangling, container'
fi

./docker-info.sh

echo "1: $1"

if [[ $1 == 'all' ]]; then
    echo "[INFO] Cleaning all images: $(docker images -q | grep -c -e .)"
    docker rmi -f $(docker images -q)
    echo '[INFO] Done.'
fi

if [[ $1 == 'none' ]]; then
    echo "[INFO] Cleaning images with <none>: $(docker images | grep '<none>' | tr -s ' ' | cut -d ' ' -f 3 | grep -c -e .)"
    docker rmi -f $(docker images | grep '<none>' | tr -s ' ' | cut -d ' ' -f 3)
    echo '[INFO] Done.'
fi

if [[ $1 == 'dangling' ]]; then
    echo "[INFO] Cleaning images with '-f "dangling=true"': $(docker images -q -f "dangling=true" | grep -c -e .)"
    docker rmi -f $(docker images -q -f "dangling=true")
    echo '[INFO] Done.'
fi

if [[ $1 == 'container' ]]; then
    echo "[INFO] Cleaning containers with status=exited: $(docker ps -q -f 'status=exited' | grep -c -e .)"
    docker rm -f $(docker ps -q -f 'status=exited')
    echo '[INFO] Done.'
fi
