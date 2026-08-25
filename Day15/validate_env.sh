#!/bin/bash


if [ -f .env ]; then
    set -a
    source .env
    set +a
fi
# Required environment variables
required_vars=("DATABASE_URL" "AWS_REGION" "APP_ENV")

missing=0

echo "Checking environment variables..."
echo "--------------------------------"

for var in "${required_vars[@]}"
do
    if [ -n "${!var}" ]; then
        echo "$var ✓"
    else
        echo "$var ✗"
        missing=1
    fi
done

echo "--------------------------------"

if [ $missing -eq 1 ]; then
    echo "Environment validation FAILED"
    exit 1
else
    echo "Environment validation PASSED"
    exit 0
fi