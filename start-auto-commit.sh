#!/bin/bash

# Start auto-commit file watcher
# Run this script to start watching for file changes

cd "$(dirname "$0")"

echo "Starting auto-commit file watcher..."
echo "This will automatically commit and push changes to GitHub when you save notes files."
echo "Press Ctrl+C to stop."
echo ""

# Check if fswatch is installed
if ! command -v fswatch &> /dev/null; then
    echo "Error: fswatch is not installed."
    echo "Install it with: brew install fswatch"
    exit 1
fi

# Watch for changes to notes.tex and notes.pdf files
fswatch -o -e ".*" -i "\\.tex$" -i "\\.pdf$" . | while read f; do
    # Filter to only notes files
    CHANGED=$(fswatch -1 -e ".*" -i "notes\\.tex$" -i "notes\\.pdf$" . 2>/dev/null)
    if [ -n "$CHANGED" ]; then
        sleep 1  # Small delay to ensure file is fully saved
        echo "[$(date '+%H:%M:%S')] Changes detected, auto-committing..."
        ./auto-commit.sh
    fi
done
