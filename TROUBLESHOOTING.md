# Troubleshooting Auto-Commit

If auto-commit isn't working, try these steps:

## 1. Verify Extension is Installed

1. Open Extensions (Cmd+Shift+X)
2. Search for "Run on Save" by emeraldwalk
3. Make sure it's **installed** and **enabled**

## 2. Check Extension Output

1. Open Output panel (Cmd+Shift+U)
2. Select "Run on Save" from the dropdown
3. Make a small change to `notes.tex` and save
4. Check if you see any output or errors

## 3. Test Script Manually

Run this to test if the script works:
```bash
cd /Users/wilsonpan/Documents/Notes
./test-auto-commit.sh
```

## 4. Check Settings

Make sure `.vscode/settings.json` contains:
```json
"emeraldwalk.runonsave": {
    "commands": [
        {
            "match": "notes\\.(tex|pdf)$",
            "cmd": "${workspaceFolder}/auto-commit.sh",
            "runIn": "workspace",
            "async": true,
            "shell": true
        }
    ]
}
```

## 5. Alternative: Use File Watcher

If the extension doesn't work, use the file watcher instead:

```bash
# Install fswatch (if not already installed)
brew install fswatch

# Start the file watcher (runs in background)
nohup ./file-watcher.sh > /dev/null 2>&1 &
```

Or run it in a terminal:
```bash
./file-watcher.sh
```

## 6. Manual Commit

If nothing works, manually commit:
```bash
./auto-commit.sh
```

## 7. Check Git Status

See what's happening:
```bash
git status
git log --oneline -5
```
