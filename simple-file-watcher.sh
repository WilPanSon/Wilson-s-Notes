#!/bin/bash

# Simple file watcher using polling (no external dependencies)
# Watches for changes to notes.tex and notes.pdf files

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

LOG_FILE="$HOME/auto-commit.log"
STATE_FILE="$HOME/.auto-commit-state"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Simple file watcher started" >> "$LOG_FILE"

# Initialize state file if it doesn't exist
if [ ! -f "$STATE_FILE" ]; then
    touch "$STATE_FILE"
fi

# Function to get file modification time
get_mod_time() {
    local file="$1"
    stat -f %m "$file" 2>/dev/null || stat -c %Y "$file" 2>/dev/null || echo "0"
}

# Function to get stored modification time
get_stored_time() {
    local file="$1"
    grep "^$file:" "$STATE_FILE" 2>/dev/null | cut -d: -f2
}

# Function to store modification time
store_mod_time() {
    local file="$1"
    local mod_time="$2"
    # Remove old entry if exists
    grep -v "^$file:" "$STATE_FILE" > "${STATE_FILE}.tmp" 2>/dev/null || true
    mv "${STATE_FILE}.tmp" "$STATE_FILE" 2>/dev/null || true
    # Add new entry
    echo "$file:$mod_time" >> "$STATE_FILE"
}

# Poll every 2 seconds
while true; do
    find . -type f \( -name "notes.tex" -o -name "notes.pdf" \) | while read -r file; do
        if [ -f "$file" ]; then
            current_mod=$(get_mod_time "$file")
            stored_mod=$(get_stored_time "$file")
            
            if [ -z "$stored_mod" ]; then
                # First time seeing this file, store its mod time
                store_mod_time "$file" "$current_mod"
            elif [ "$current_mod" != "$stored_mod" ] && [ "$current_mod" != "0" ]; then
                # File has changed
                echo "[$(date '+%Y-%m-%d %H:%M:%S')] File changed: $file" >> "$LOG_FILE"
                store_mod_time "$file" "$current_mod"
                
                # Run auto-commit (with a small delay to avoid multiple rapid commits)
                sleep 1
                "$SCRIPT_DIR/auto-commit.sh" >> "$LOG_FILE" 2>&1 &
            fi
        fi
    done
    sleep 2
done
