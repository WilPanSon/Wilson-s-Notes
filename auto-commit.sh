#!/bin/bash

# Auto-commit script for notes
# This script commits and pushes changes to GitHub

cd "$(dirname "$0")"

# Check if there are any changes
if git diff-index --quiet HEAD --; then
    echo "No changes to commit"
    exit 0
fi

# Add all changes
git add -A

# Create commit with timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
git commit -m "Auto-update: $TIMESTAMP"

# Push to GitHub (assuming 'origin' remote is set)
git push origin main 2>/dev/null || git push origin master 2>/dev/null

echo "Changes committed and pushed successfully"
