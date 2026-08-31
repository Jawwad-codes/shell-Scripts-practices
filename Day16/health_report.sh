#!/bin/bash

echo "============SERVER HEALTH REPORT==============="


echo "Hostname: $(hostname)"
echo "Uptime: $(uptime -p)"
echo "Cpu: $(top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " $2 + $4 "%"}')"
echo "Memory: $(free -h | grep "Mem:" | awk '{print "Used: " $3}')"
echo "Disk: $(df -h --output=source,size,used,avail,pcent,target -x tmpfs -x devtmpfs)"

echo "--- Running Services (top 20 by memory) ---"
systemctl list-units --type=service --state=running --no-pager | head -n 20


echo "--- Open Ports ---"
ss -tulnp 2>/dev/null || netstat -tulnp

echo "--- Docker Containers ---"
if command -v docker &> /dev/null; then
    docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
else
    echo "Docker not installed"
fi
echo ""
echo "--- Top Processes (by CPU) ---"
ps aux --sort=-%cpu | head -n 6
echo ""
echo "===== END OF REPORT ====="
