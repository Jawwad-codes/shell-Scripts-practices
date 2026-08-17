#!/bin/bash


if [ -z "$1" ]; then
  echo "Usage: $0 atleast one username is required"
  exit 1
fi

array=("$@")

for username in "${array[@]}"; do
    if id "$username" &>/dev/null; then
        echo "User '$username' already exists."
    else
        sudo useradd "$username"
        echo "User '$username' has been created."
    fi
done
echo "---------------------------------"
