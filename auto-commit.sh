#!/bin/bash

# Auto-commit script for notes
# This script commits and pushes changes to GitHub

# Log to a file for debugging (optional)
# LOG_FILE="$HOME/auto-commit.log"
# echo "[$(date '+%Y-%m-%d %H:%M:%S')] Auto-commit triggered" >> "$LOG_FILE"

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
git commit -m "Auto-update: $TIMESTAMP" 2>/dev/null

# Check if remote is configured
if git remote get-url origin >/dev/null 2>&1; then
    # Get current branch name
    BRANCH=$(git branch --show-current 2>/dev/null || echo "main")
    
    # Push to GitHub (don't suppress errors, but don't fail if push fails)
    git push origin "$BRANCH" 2>&1 || {
        # If push fails, it's okay - might be network issue or auth issue
        # The commit is still made locally
        exit 0
    }
else
    echo "GitHub remote not configured. Run: git remote add origin <your-repo-url>"
    exit 0
fi
