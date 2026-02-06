#!/bin/bash

# Auto-commit daemon that watches for file changes
# This script runs in the background and automatically commits changes

cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"
LOG_FILE="$HOME/.auto-commit-notes.log"

# Function to log messages
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

log "Starting auto-commit daemon..."

# Check if fswatch is installed
if ! command -v fswatch &> /dev/null; then
    log "ERROR: fswatch not found. Install with: brew install fswatch"
    exit 1
fi

# Watch for changes to notes.tex and notes.pdf files
fswatch -o -e ".*" -i "notes\\.tex$" -i "notes\\.pdf$" "$SCRIPT_DIR" | while read f; do
    sleep 1  # Small delay to ensure file is fully saved
    log "Change detected, running auto-commit..."
    cd "$SCRIPT_DIR"
    "$SCRIPT_DIR/auto-commit.sh" >> "$LOG_FILE" 2>&1
done
