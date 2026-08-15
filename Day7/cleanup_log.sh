#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 Log Directory Required"
  exit 1
fi

# check the files older than 7 days and display the list of files to be deleted
find "$1" -type f -mtime +7 -name "*.log" -print

count=$(find "$1" -type f -mtime +7 -name "*.log" | wc -l)

if [[ $count == 0 ]]; then
    echo "No log files older than 7 days found in the specified directory."
    exit 0
fi

read -p "Do you want to delete these files? (y/n): " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    # delete the files older than 7 days
    find "$1" -type f -mtime +7 -name "*.log" | xargs rm -f;
    echo "Files older than 7 days have been deleted."
else
    echo "No files were deleted."
fi