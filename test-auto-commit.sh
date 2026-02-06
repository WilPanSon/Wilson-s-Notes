#!/bin/bash

# Test script to verify auto-commit is working
cd "$(dirname "$0")"

echo "=== Testing Auto-Commit Script ==="
echo "Current directory: $(pwd)"
echo ""

# Check git status
echo "Git status:"
git status --short
echo ""

# Run the auto-commit script
echo "Running auto-commit.sh..."
./auto-commit.sh

echo ""
echo "=== After Auto-Commit ==="
git status --short
echo ""
echo "Recent commits:"
git log --oneline -3
