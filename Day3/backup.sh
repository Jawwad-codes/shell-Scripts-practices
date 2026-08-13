#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# check the directory exists
if [ ! -d "$1" ]; then
  echo "Error: $1 is not a valid directory."
  exit 1
fi


mkdir -p /tmp/backups

DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="/tmp/backups/backup_$(basename "$1")-$DATE.tar.gz"
tar -czf "$BACKUP_FILE" -C "$(dirname "$1")" "$(basename "$1")"

# check if the backup was successful 
if [ $? -eq 0 ]; then
  echo "Backup of $1 completed successfully. Backup file: $BACKUP_FILE"
else
  echo "Error: Backup failed."
  exit 1
fi