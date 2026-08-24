#!/bin/bash

echo "Backing up Git repository..."

BACKUP_ROOT="$HOME/git_backup"
mkdir -p "$BACKUP_ROOT"

if [ -z "$1" ]; then
    echo "Usage: $0 /path/to/git/repo"
    exit 1
fi

REPO_PATH=$(realpath "$1")   # resolve to absolute path

if [ ! -d "$REPO_PATH" ]; then
    echo "Error: '$REPO_PATH' is not a directory."
    exit 1
fi

# Check that it is a Git repository
if ! git -C "$REPO_PATH" rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: '$REPO_PATH' is not a valid Git repository."
    exit 1
fi

SHORT_HASH=$(git -C "$REPO_PATH" rev-parse --short HEAD)
REPO_NAME=$(basename "$REPO_PATH")
BACKUP_FILE="$BACKUP_ROOT/${REPO_NAME}_backup_${SHORT_HASH}.tar.gz"

echo "Creating backup of $REPO_PATH → $BACKUP_FILE"

tar -czf "$BACKUP_FILE" -C "$(dirname "$REPO_PATH")" "$REPO_NAME"

if [ $? -eq 0 ]; then
    echo "Backup created successfully: $BACKUP_FILE"
else
    echo "Backup failed."
    exit 1
fi