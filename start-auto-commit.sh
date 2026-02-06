#!/bin/bash

# Start script for auto-commit file watcher
# This script starts the file watcher in the background

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# Check if watcher is already running
if pgrep -f "simple-file-watcher.sh" > /dev/null; then
    echo "File watcher is already running!"
    exit 0
fi

# Start the file watcher in the background
# Use absolute path and ensure we're in the right directory
nohup bash "$SCRIPT_DIR/simple-file-watcher.sh" > /dev/null 2>&1 &

# Give it a moment to start
sleep 0.5

# Verify it started
if pgrep -f "simple-file-watcher.sh" > /dev/null; then
    echo "✓ Auto-commit file watcher started successfully!"
    echo "  To stop it, run: pkill -f simple-file-watcher.sh"
    echo "  To check logs, run: tail -f ~/auto-commit.log"
else
    echo "⚠ Failed to start file watcher. Check ~/auto-commit.log for errors."
    exit 1
fi
