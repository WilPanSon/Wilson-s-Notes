#!/bin/bash

# Script to start the auto-commit service
# This will install and start a background service that watches for file changes

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLIST_FILE="$SCRIPT_DIR/com.wilsonpan.auto-commit.plist"
LAUNCH_AGENTS_DIR="$HOME/Library/LaunchAgents"
SERVICE_NAME="com.wilsonpan.auto-commit"

echo "Setting up auto-commit service..."
echo ""

# Check if fswatch is installed
if ! command -v fswatch &> /dev/null; then
    echo "Installing fswatch..."
    brew install fswatch
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to install fswatch. Please install manually: brew install fswatch"
        exit 1
    fi
fi

# Stop existing service if running
if launchctl list | grep -q "$SERVICE_NAME"; then
    echo "Stopping existing service..."
    launchctl unload "$LAUNCH_AGENTS_DIR/$SERVICE_NAME.plist" 2>/dev/null
fi

# Copy plist file to LaunchAgents
echo "Installing service..."
mkdir -p "$LAUNCH_AGENTS_DIR"
cp "$PLIST_FILE" "$LAUNCH_AGENTS_DIR/$SERVICE_NAME.plist"

# Load the service
launchctl load "$LAUNCH_AGENTS_DIR/$SERVICE_NAME.plist"

if [ $? -eq 0 ]; then
    echo ""
    echo "✓ Auto-commit service started successfully!"
    echo ""
    echo "The service will automatically commit and push your notes to GitHub"
    echo "whenever you save notes.tex or notes.pdf files."
    echo ""
    echo "To check the service status:"
    echo "  launchctl list | grep $SERVICE_NAME"
    echo ""
    echo "To view logs:"
    echo "  tail -f ~/.auto-commit-notes.log"
    echo ""
    echo "To stop the service:"
    echo "  launchctl unload $LAUNCH_AGENTS_DIR/$SERVICE_NAME.plist"
    echo ""
else
    echo "ERROR: Failed to start service"
    exit 1
fi
