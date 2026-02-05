#!/bin/bash

# File watcher script for auto-committing notes
# This script watches for file changes and auto-commits them

cd "$(dirname "$0")"

echo "Starting file watcher for auto-commit..."
echo "Watching for changes in: $(pwd)"
echo "Press Ctrl+C to stop"

# Check if fswatch is installed (macOS)
if command -v fswatch &> /dev/null; then
    fswatch -o . | while read f; do
        # Small delay to avoid multiple commits for rapid saves
        sleep 2
        echo "Changes detected, committing..."
        ./auto-commit.sh
    done
elif command -v inotifywait &> /dev/null; then
    # Linux alternative
    while inotifywait -r -e modify,create,delete .; do
        sleep 2
        echo "Changes detected, committing..."
        ./auto-commit.sh
    done
else
    echo "Error: fswatch (macOS) or inotifywait (Linux) not found."
    echo "Please install fswatch: brew install fswatch"
    exit 1
fi
