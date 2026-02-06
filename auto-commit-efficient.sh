#!/bin/bash

# More battery-efficient auto-commit script
# Only watches when files are actually being edited (uses fswatch with debouncing)

cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"
LOG_FILE="$HOME/.auto-commit-notes.log"

# Function to log messages
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

log "Starting efficient auto-commit watcher..."

# Check if fswatch is installed
if ! command -v fswatch &> /dev/null; then
    log "ERROR: fswatch not found. Install with: brew install fswatch"
    exit 1
fi

# Use fswatch with debouncing - waits 3 seconds after last change before committing
# This reduces battery usage by batching multiple rapid saves
LAST_COMMIT=0
DEBOUNCE_TIME=3

fswatch -o -e ".*" -i "notes\\.tex$" -i "notes\\.pdf$" "$SCRIPT_DIR" | while read f; do
    CURRENT_TIME=$(date +%s)
    
    # Only commit if enough time has passed since last commit (debouncing)
    if [ $((CURRENT_TIME - LAST_COMMIT)) -ge $DEBOUNCE_TIME ]; then
        sleep 1  # Small delay to ensure file is fully saved
        log "Change detected, running auto-commit..."
        cd "$SCRIPT_DIR"
        "$SCRIPT_DIR/auto-commit.sh" >> "$LOG_FILE" 2>&1
        LAST_COMMIT=$(date +%s)
    else
        log "Change detected but debouncing (waiting for more changes)..."
    fi
done
