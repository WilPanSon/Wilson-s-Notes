# Notes Repository

This repository contains my academic notes.

## Quick Setup

### 1. Create GitHub Repository

1. Go to [GitHub](https://github.com) and create a new repository
2. Copy the repository URL (e.g., `https://github.com/yourusername/notes.git`)

### 2. Connect to GitHub (Easy Way)

Run the setup script:

```bash
./setup-github.sh
```

Follow the prompts to enter your GitHub repository URL.

### 3. Set Up Auto-Commit on Save

#### Automatic Setup (Recommended)

The file watcher **automatically starts** when you open this workspace in VS Code/Cursor! 

The configuration is already set up in `.vscode/tasks.json` to run on folder open. When you open the workspace, you'll see a notification that the file watcher has started.

**Manual control:**

- **Start watcher manually:** Run the task "Start Auto-commit File Watcher" (Cmd+Shift+P → "Tasks: Run Task")
- **Stop watcher:** Run the task "Stop Auto-commit File Watcher" or: `pkill -f simple-file-watcher.sh`
- **Check logs:** `tail -f ~/auto-commit.log`
- **Check if running:** `pgrep -f simple-file-watcher.sh`

#### Manual Start (Alternative)

If automatic start doesn't work, you can manually start the file watcher:

```bash
./start-auto-commit.sh
```

This will start a background process that watches for changes to `notes.tex` and `notes.pdf` files and automatically commits and pushes them to GitHub.

#### Option B: Using fswatch (Alternative)

1. Make sure `fswatch` is installed (macOS):
   ```bash
   brew install fswatch
   ```

2. Run the file watcher script:
   ```bash
   ./file-watcher.sh
   ```

   Or run it in the background:
   ```bash
   nohup ./file-watcher.sh > /dev/null 2>&1 &
   ```

### 4. Configure Git (if not already done)

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## Manual Setup (Alternative)

If you prefer to set up manually:

```bash
# Initialize git (if not already done)
git init
git add .
git commit -m "Initial commit"

# Add GitHub remote
git remote add origin https://github.com/yourusername/notes.git
git branch -M main
git push -u origin main
```

## How It Works

- When you save a file, the `auto-commit.sh` script runs automatically
- It checks for changes, commits them with a timestamp, and pushes to GitHub
- Build artifacts (`.aux`, `.log`, etc.) are ignored via `.gitignore`
- The script handles cases where GitHub remote is not configured

## Manual Commit

If you want to manually commit changes:

```bash
./auto-commit.sh
```

Or use standard git commands:

```bash
git add .
git commit -m "Your commit message"
git push
```

## Troubleshooting

- **Auto-commit not working?** 
  - Make sure the file watcher is running: `pgrep -f simple-file-watcher.sh`
  - If not running, start it: `./start-auto-commit.sh`
  - Check the log file: `tail -f ~/auto-commit.log`
- **Push fails?** Check that your GitHub remote is configured: `git remote -v`
- **Permission errors?** Make sure your GitHub credentials are set up (use SSH keys or GitHub CLI)
- **File watcher not starting?** Make sure the scripts are executable: `chmod +x *.sh`
