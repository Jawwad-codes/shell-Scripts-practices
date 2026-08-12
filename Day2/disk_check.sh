#!/bin/bash

readonly Disk_usage=$(df -h | grep "sdb2" | awk '{print $5}' | tr -d '%')

if [ "$Disk_usage" -gt 70 ];
then
    echo "disk usage is High ${Disk_usage}%"
    exit 1
else
    echo "Disk usage is Healthy ${Disk_usage}%"
fi

	


