#!/bin/bash

# Auto-commit script for notes
# This script commits and pushes changes to GitHub

# Log to a file for debugging
LOG_FILE="$HOME/auto-commit.log"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Auto-commit triggered" >> "$LOG_FILE"

cd "$(dirname "$0")"

# Check if git is initialized
if [ ! -d .git ]; then
    echo "Git repository not initialized. Run 'git init' first."
    exit 1
fi

# Check if there are any changes
if git diff-index --quiet HEAD -- 2>/dev/null; then
    # Also check for untracked files
    if [ -z "$(git ls-files --others --exclude-standard)" ]; then
        exit 0
    fi
fi

# Add all changes
git add -A

# Create commit with timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
if ! git commit -m "Auto-update: $TIMESTAMP" >> "$LOG_FILE" 2>&1; then
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Warning: Commit failed or no changes to commit" >> "$LOG_FILE"
    exit 0
fi
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Commit successful" >> "$LOG_FILE"

# Check if remote is configured
if git remote get-url origin >/dev/null 2>&1; then
    # Get current branch name
    BRANCH=$(git branch --show-current 2>/dev/null || echo "main")
    
    # Push to GitHub
    if git push origin "$BRANCH" >> "$LOG_FILE" 2>&1; then
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Push successful" >> "$LOG_FILE"
    else
        echo "[$(date '+%Y-%m-%d %H:%M:%S')] Warning: Push failed (check log for details)" >> "$LOG_FILE"
        # Don't fail - commit is still made locally
        exit 0
    fi
else
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Warning: GitHub remote not configured" >> "$LOG_FILE"
    exit 0
fi
