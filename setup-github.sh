#!/bin/bash

# Setup script for connecting to GitHub

cd "$(dirname "$0")"

echo "GitHub Repository Setup"
echo "======================="
echo ""

# Check if git is initialized
if [ ! -d .git ]; then
    echo "Initializing git repository..."
    git init
    git add .
    git commit -m "Initial commit"
fi

# Check if remote already exists
if git remote get-url origin >/dev/null 2>&1; then
    echo "Remote 'origin' already configured:"
    git remote get-url origin
    echo ""
    read -p "Do you want to change it? (y/n) " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git remote remove origin
    else
        echo "Keeping existing remote."
        exit 0
    fi
fi

# Get GitHub repository URL
echo "Enter your GitHub repository URL (e.g., https://github.com/username/repo.git):"
read -r REPO_URL

if [ -z "$REPO_URL" ]; then
    echo "No URL provided. Exiting."
    exit 1
fi

# Add remote
git remote add origin "$REPO_URL"

# Set branch to main
git branch -M main 2>/dev/null || git branch -M master

# Push to GitHub
echo ""
echo "Pushing to GitHub..."
git push -u origin main 2>/dev/null || git push -u origin master 2>/dev/null

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ Successfully connected to GitHub!"
    echo ""
    echo "Auto-commit is now set up. Your changes will be automatically"
    echo "committed and pushed when you save files (if you have the"
    echo "'Run on Save' extension installed)."
else
    echo ""
    echo "⚠ Could not push to GitHub. Please check:"
    echo "  1. The repository URL is correct"
    echo "  2. You have push access to the repository"
    echo "  3. Your GitHub credentials are configured"
    echo ""
    echo "You can manually push later with: git push -u origin main"
fi
