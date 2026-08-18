#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 atleast one port number is required"
  exit 1
fi


result=("$@")

for port in "${result[@]}"; do
    if sudo ss -tuln | grep -q ":$port "; then
        echo "Port '$port' is already in use. meaning it is open."
    else
        echo "Port '$port' is available. meaning it is not in use and closed."
    fi
done