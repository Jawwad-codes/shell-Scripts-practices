#!/bin/bash

missing=0

for var in "$@"
do
    if [ -n "${!var}" ]; then
        echo "$var ✓"
    else
        echo "$var ✗"
        missing=1
    fi
done

if [ $missing -eq 1 ]; then
    echo "Environment validation FAILED"
    exit 1
else
    echo "Environment validation PASSED"
    exit 0
fi