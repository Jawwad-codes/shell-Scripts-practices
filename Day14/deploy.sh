#!/bin/bash

if [ -z "$2" ]; then
  echo "Path to the deployment directory is required as an argument."
  echo "url: github.com url"
  exit 1
fi


DEPLOY_DIR="$1"
Url="$2"

cd "$DEPLOY_DIR" || { echo "Failed to change directory to $DEPLOY_DIR"; exit 1; }

# clone the latest version of the repository

git clone "$Url" || { echo "Failed to clone the repository"; exit 1; }
basename=$(basename "$Url" .git)
cd "$basename" || { echo "Failed to change directory to $basename"; exit 1; }

# install dependencies
npm ci || { echo "Failed to install dependencies"; exit 1; }

# build the project
npm run build || { echo "Failed to build the project"; exit 1; }

# build the Docker image
docker build -t "$basename" . || { echo "Failed to build the Docker image"; exit 1; }

# stop and remove any existing container with the same name
docker stop "$basename"-container 2>/dev/null || true
docker rm "$basename"-container 2>/dev/null || true

# run the Docker container
docker run -d -p 3000:80 --name "$basename"-container "$basename" || { echo "Failed to run the Docker container"; exit 1; }

# check container status
if [ "$(docker inspect -f '{{.State.Running}}' "$basename"-container)" == "true" ]; then
  echo "Deployment successful. The application is running in the Docker container."
else
  echo "Deployment failed. The Docker container is not running."
  exit 1
fi

# test the application
curl -I http://localhost:3000 || { echo "Failed to access the application"; exit 1; }
