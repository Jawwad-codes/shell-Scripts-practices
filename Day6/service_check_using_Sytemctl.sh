#!/bin/bash
# set color codes for output 

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# check if at least one service name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <service1> [service2] ..."
    exit 1
fi

overall_status=0

# check if service is running using systemctl
for service in "$@"; do
    service="${service}.service"
    echo "----------------------------------------"
    echo "Checking service: $service"
    if ! systemctl list-unit-files --type=service 2>/dev/null | grep -iw "${service}"; 
    then
        echo -e "${RED}✗ '$service' does not exist as a systemd service.${NC}"
        overall_status=1
        continue
    fi

    if systemctl is-active --quiet "${service}" 2>/dev/null; then
        echo -e "${GREEN}✓ $service is running.${NC}"
    else
        state=$(systemctl is-active  "${service}" 2>/dev/null || echo "unknown")
        echo -e "${YELLOW}⚠ WARNING: $service exists but is NOT running (state: ${state}).${NC}"
        overall_status=1
    fi
done

echo "--------------------END---------------------"
exit $overall_status