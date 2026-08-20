#!/bin/bash

# Check if Docker is installed
if ! command -v docker >/dev/null 2>&1; then
    echo "Docker is not installed."
    exit 1
fi

# Check if Docker daemon is running
if ! docker info >/dev/null 2>&1; then
    echo "Docker is not running. Please start Docker service first."
    exit 1
fi

# Header function for consistent table look
print_header() {
    printf "%-25s %-30s %-35s\n" "CONTAINER" "IMAGE" "STATUS"
    printf "%-25s %-30s %-35s\n" "-------------------------" "------------------------------" "-----------------------------------"
}

echo
echo "=============================================="
echo "           RUNNING CONTAINERS"
echo "=============================================="
echo

print_header

# Running containers
docker ps --format '{{.Names}}\t{{.Image}}\t{{.Status}}' | while IFS=$'\t' read -r name image status; do
    printf "%-25s %-30s %-35s\n" "$name" "$image" "$status"
done

# Count running
running_count=$(docker ps -q | wc -l)
if [ "$running_count" -eq 0 ]; then
    echo "(no running containers)"
fi

echo
echo "=============================================="
echo "        STOPPED / EXITED CONTAINERS"
echo "=============================================="
echo

print_header

# Stopped / exited / created containers
docker ps -a --filter "status=exited" --filter "status=created" --filter "status=dead" \
    --format '{{.Names}}\t{{.Image}}\t{{.Status}}' | while IFS=$'\t' read -r name image status; do
    printf "%-25s %-30s %-35s\n" "$name" "$image" "$status"
done

# Count stopped
stopped_count=$(docker ps -a --filter "status=exited" --filter "status=created" --filter "status=dead" -q | wc -l)
if [ "$stopped_count" -eq 0 ]; then
    echo "(no stopped containers)"
fi

echo
echo "=============================================="
echo " Summary:  Running: $running_count   |   Stopped: $stopped_count"
echo "=============================================="
echo