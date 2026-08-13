#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <log_file>"
  exit 1
fi

if [ ! -f "$1" ]; then
  echo "Error: $1 is not a valid file."
  exit 1
fi

# for Total Lines
TOTAL_LINES=$(wc -l < "$1")
# for Total Error count
ERROR_COUNT=$(grep -c "ERROR" "$1")
# for Total Warning count
WARNING_COUNT=$(grep -c "WARNING" "$1")
#for Total Info count
INFO_COUNT=$(grep -c "INFO" "$1")
# for Top 5 unique ip addresses
TOP_IPS=$(awk '{print $4}' "$1" | sort | uniq -c | sort -nr| head -n 5)

# check if the log analysis was successful
if [ $? -eq 0 ]; then
  echo "Log analysis of $1 completed successfully."
  echo "Total Lines: $TOTAL_LINES"
  echo "Total Error Count: $ERROR_COUNT"
  echo "Total Warning Count: $WARNING_COUNT"
  echo "Total Info Count: $INFO_COUNT"
  echo "Top 5 Unique IP Addresses:"
  echo "$TOP_IPS"
else
  echo "Error: Log analysis failed."
    exit 1
fi

