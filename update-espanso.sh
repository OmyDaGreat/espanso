#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$HOME/.config/espanso"
BRANCH="master"
REMOTE="origin"

echo "[espanso-sync] Starting sync in: $REPO_DIR"
cd "$REPO_DIR"

echo "[espanso-sync] Staging all changes (new, modified, deleted)..."
git add -A

if ! git diff --cached --quiet; then
    echo "[espanso-sync] Detected local changes. Committing..."
    git commit -m "Auto-sync: $(date '+%Y-%m-%d %H:%M:%S')"
else
    echo "[espanso-sync] No local changes to commit."
fi

echo "[espanso-sync] Pulling remote changes (with rebase)..."
git pull --rebase $REMOTE $BRANCH || {
    echo "[espanso-sync] WARNING: Pull/rebase failed (possible conflict). Resolve manually."
    exit 1
}

echo "[espanso-sync] Pushing local commits to remote..."
git push $REMOTE $BRANCH

echo "[espanso-sync] Sync complete."
