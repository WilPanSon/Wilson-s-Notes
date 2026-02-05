# Notes Repository

This repository contains my academic notes and homework assignments.

## Setup Instructions

### 1. Initialize Git Repository

```bash
cd /Users/wilsonpan/Documents/Notes
git init
git add .
git commit -m "Initial commit"
```

### 2. Create GitHub Repository

1. Go to [GitHub](https://github.com) and create a new repository
2. Copy the repository URL (e.g., `https://github.com/yourusername/notes.git`)

### 3. Connect to GitHub

```bash
git remote add origin https://github.com/yourusername/notes.git
git branch -M main
git push -u origin main
```

### 4. Set Up Auto-Commit on Save

You have two options:

#### Option A: Using VS Code/Cursor Extension (Recommended)

1. Install the "Run on Save" extension in VS Code/Cursor:
   - Open Extensions (Cmd+Shift+X)
   - Search for "Run on Save" by emeraldwalk
   - Install it

2. The settings are already configured in `.vscode/settings.json`

3. The auto-commit script will run automatically when you save `.tex`, `.md`, or `.txt` files

#### Option B: Using File Watcher Script

1. Make sure `fswatch` is installed (macOS):
   ```bash
   brew install fswatch
   ```

2. Run the file watcher script:
   ```bash
   chmod +x file-watcher.sh
   ./file-watcher.sh
   ```

   Or run it in the background:
   ```bash
   nohup ./file-watcher.sh > /dev/null 2>&1 &
   ```

### 5. Configure Git (if not already done)

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## How It Works

- When you save a file, the `auto-commit.sh` script runs automatically
- It checks for changes, commits them with a timestamp, and pushes to GitHub
- Build artifacts (`.aux`, `.log`, etc.) are ignored via `.gitignore`

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
