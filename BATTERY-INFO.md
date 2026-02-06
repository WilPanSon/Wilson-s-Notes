# Battery Consumption Information

## File Watcher Service

The auto-commit file watcher service uses **minimal battery** because:

1. **Event-driven**: Uses macOS file system events (FSEvents API) - no continuous polling
2. **Efficient**: Only activates when files actually change
3. **Debounced**: Waits 3 seconds after your last save before committing (batches rapid saves)
4. **Lightweight**: Uses native macOS APIs, not CPU-intensive polling

### Estimated Battery Impact
- **Idle (no file changes)**: ~0% additional battery drain
- **Active editing**: Minimal - similar to having a text editor open
- **During commits**: Brief CPU usage (1-2 seconds) when committing/pushing

### Comparison
- **File watcher**: ~0-1% battery impact (only when editing)
- **VS Code extension**: ~0% battery impact (runs only when you save)
- **Manual commits**: 0% battery impact (but requires manual action)

## Recommendations

### Option 1: Use VS Code Extension (Most Battery Efficient)
The "Run on Save" extension only runs when you save files - zero battery drain when idle.

**To fix the extension:**
1. Make sure it's installed: Extensions → Search "Run on Save" by emeraldwalk
2. Reload Cursor/VS Code (Cmd+Shift+P → "Reload Window")
3. Test by making a small change and saving

### Option 2: Background Service (Low Battery Impact)
The file watcher service is very efficient, but if you're concerned:

- **Stop when not needed**: `launchctl unload ~/Library/LaunchAgents/com.wilsonpan.auto-commit.plist`
- **Start when needed**: `launchctl load ~/Library/LaunchAgents/com.wilsonpan.auto-commit.plist`
- **Check if running**: `launchctl list | grep com.wilsonpan.auto-commit`

### Option 3: Manual Commits (Zero Battery Impact)
Just run `./auto-commit.sh` when you want to commit.

## My Recommendation

**Try fixing the VS Code extension first** - it's the most battery-efficient option. If that doesn't work, the file watcher service has minimal battery impact and is worth it for the convenience.
