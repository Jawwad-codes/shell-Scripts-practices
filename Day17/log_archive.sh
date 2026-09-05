#!/bin/bash

# find the sample_logs directory
DIR=$(find / -type d -name "sample_logs" -print -quit 2>/dev/null)

if [ -z "$DIR" ] || [ ! -d "$DIR" ]; then
    echo "Directory 'sample_logs' not found"
    exit 1
fi

echo "Found directory: $DIR"

#  Create log_archive folder in home if it doesn't exist
ARCHIVE_DIR="$HOME/log_archive"

if [ ! -d "$ARCHIVE_DIR" ]; then
    mkdir -p "$ARCHIVE_DIR"
    echo "Created archive directory: $ARCHIVE_DIR"
else
    echo "Archive directory already exists: $ARCHIVE_DIR"
fi

# Find .log files older than 7 days, compress them, and move to archive
echo "Looking for log files older than 7 days..."

find "$DIR" -type f -name "*.log" -mtime +7 \
  -exec gzip {} \; \
  -exec mv {}.gz "$ARCHIVE_DIR/" \;      # move the compressed file to archive

echo "Done."


# now i delete the logs older than 7 days 

find "$DIR" -type f -name "*.log" -mtime +7 | xargs -0 rm -f 