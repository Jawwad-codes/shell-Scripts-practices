#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 atleast one service name"
  exit 1
fi

overall_status=0
if [ $# -gt 0 ]; then
   array=("$@")
    for service in "${array[@]}"; do
        pgrep -i "$service" > /dev/null 
        if [ $? -eq 0 ]; then
            echo "Service $service is running."
        else
            echo "Service $service is not running."
            overall_status=1
        fi
    done
    exit $overall_status
fi