# Fixing the Run on Save Extension

## Battery Impact: **ZERO when idle** (most efficient option!)

The VS Code extension only runs when you save files - it has zero battery drain when you're not editing.

## Steps to Fix:

1. **Verify Extension is Installed**
   - Open Extensions (Cmd+Shift+X)
   - Search for "Run on Save" by emeraldwalk
   - Make sure it's installed and **enabled**

2. **Reload Cursor/VS Code**
   - Press `Cmd+Shift+P`
   - Type "Reload Window" and press Enter
   - This ensures the extension picks up the new settings

3. **Test It**
   - Make a small change to any `notes.tex` file
   - Save the file (Cmd+S)
   - Check the Output panel (Cmd+Shift+U) → Select "Run on Save"
   - You should see the script running

4. **Check GitHub**
   - Visit: https://github.com/WilPanSon/Wilson-s-Notes
   - You should see new commits appearing automatically

## If It Still Doesn't Work:

### Option A: Check Extension Output
1. Open Output panel (Cmd+Shift+U)
2. Select "Run on Save" from dropdown
3. Save a file and check for errors

### Option B: Use Background Service (Low Battery Impact)
If the extension won't work, use the file watcher service:
```bash
./start-auto-commit-service.sh
```

The file watcher uses minimal battery (~0-1% when actively editing, 0% when idle).

### Option C: Manual Commits (Zero Battery)
Just run `./auto-commit.sh` whenever you want to commit.
