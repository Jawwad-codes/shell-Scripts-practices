#!/bin/bash

echo "Stopped containers found:"
docker ps -a --filter "status=exited" --filter "status=created"

printf "Do you want to remove all stopped containers? (y/n): "
read response

if [[ "$response" =~ ^[Yy]$ ]]; then
    echo "Removing all stopped containers..."
    docker container prune -f
    docker images --filter "dangling=true" 

    printf "Also remove all unused images? (y/n): "
    read img_response
    if [[ "$img_response" =~ ^[Yy]$ ]]; then
        echo "Removing all unused images..."
        docker image prune --filter "dangling=true" -f
    fi
else
    echo "Cancelled."
fi