#!/bin/bash

echo "Hostname: $(hostname)"
echo "os: $(uname)"
echo "Kernel: $(uname -n)"
# uname -r for kernel relase with name
# uname -a for all info
# uname -m for architecture
echo "Uptime: $(uptime)"
echo "Memory: $(free -h)"
echo "Disk: $(df -h | grep "sdb2")"
echo "Ip Address: $(ip addr | grep /24 | awk '{print $2}')"
echo "Logged-in User:$(whoami)"
echo "Current Date: $(date)"

