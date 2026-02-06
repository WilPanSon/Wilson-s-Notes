#!/bin/bash

# Start script for auto-commit file watcher
# This script starts the file watcher in the background

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# Check if watcher is already running
if pgrep -f "simple-file-watcher.sh" > /dev/null; then
    echo "File watcher is already running!"
    exit 1
fi

# Start the file watcher in the background
nohup "$SCRIPT_DIR/simple-file-watcher.sh" > /dev/null 2>&1 &

echo "Auto-commit file watcher started!"
echo "To stop it, run: pkill -f simple-file-watcher.sh"
echo "To check logs, run: tail -f ~/auto-commit.log"
