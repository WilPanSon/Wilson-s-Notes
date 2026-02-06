#!/bin/bash

# File watcher script for auto-committing notes
# This script watches for changes to notes.tex and notes.pdf files
# and automatically commits and pushes them to GitHub

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# Check if fswatch is installed
if ! command -v fswatch &> /dev/null; then
    echo "Error: fswatch is not installed."
    echo "Install it with: brew install fswatch"
    exit 1
fi

# Log file
LOG_FILE="$HOME/auto-commit.log"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] File watcher started" >> "$LOG_FILE"

# Function to debounce commits (wait a bit before committing)
LAST_COMMIT_TIME=0
DEBOUNCE_SECONDS=5

commit_changes() {
    local current_time=$(date +%s)
    local time_since_last_commit=$((current_time - LAST_COMMIT_TIME))
    
    if [ $time_since_last_commit -lt $DEBOUNCE_SECONDS ]; then
        # Too soon since last commit, skip
        return
    fi
    
    LAST_COMMIT_TIME=$current_time
    
    # Run the auto-commit script
    "$SCRIPT_DIR/auto-commit.sh" &
}

# Watch for changes to notes.tex and notes.pdf files
# -r: recursive
# -m: monitor (keep running)
# -e: exclude patterns (we'll filter in the script)
fswatch -r -m poll_monitor --exclude='.*' --include='notes\.tex$' --include='notes\.pdf$' . | while read -r event; do
    # Filter to only notes.tex and notes.pdf files
    if [[ "$event" =~ notes\.(tex|pdf)$ ]]; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] File changed: $event" >> "$LOG_FILE"
        commit_changes
    fi
done
