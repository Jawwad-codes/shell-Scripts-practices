#!/bin/bash


if [ -z "$1" ]; then
  echo "Usage: $0 atleast one website is required"
  exit 1
fi

result=("$@")
for website in "${result[@]}"; do
    echo "Checking website: $website"
    curl -o /dev/null -s -w " HTTP Status: %{http_code}\n Respone Time: %{time_total}s\n Website URL: %{url_effective}\n IP Address: %{remote_ip}\n"  "$website"
    echo " website check completed for: $website "
done

