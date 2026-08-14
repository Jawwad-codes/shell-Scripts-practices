#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <service_name>"
  exit 1
fi

pgrep -i "$1" > /dev/null 

if [ $? -eq 0 ]; then
  echo "Service $1 is running."
else
  echo "Service $1 is not running."
  exit 1
fi