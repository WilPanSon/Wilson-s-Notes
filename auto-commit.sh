#!/bin/bash

# Auto-commit script for notes
# This script commits and pushes changes to GitHub

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
    
    # Push to GitHub
    git push origin "$BRANCH" 2>/dev/null || {
        echo "Warning: Could not push to GitHub. Make sure remote is configured."
        exit 0
    }
else
    echo "GitHub remote not configured. Run: git remote add origin <your-repo-url>"
    exit 0
fi
