# Notes Repository

This repository contains my academic notes and homework assignments.

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

- **Auto-commit not working?** Make sure the "Run on Save" extension is installed and enabled
- **Push fails?** Check that your GitHub remote is configured: `git remote -v`
- **Permission errors?** Make sure your GitHub credentials are set up (use SSH keys or GitHub CLI)
