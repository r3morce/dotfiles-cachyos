#!/usr/bin/env bash
# deploy.sh - Deploy dotfiles from repo to home directory
# ALWAYS creates timestamped backups before overwriting files

set -e

# ============================================================
# Configuration
# ============================================================

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Backup directory with timestamp
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d_%H%M%S)"

# Dotfiles to deploy (source:destination)
DOTFILES=(
    "zsh/.zshrc:$HOME/.zshrc"
    "p10k/.p10k.zsh:$HOME/.p10k.zsh"
    "wezterm/wezterm.lua:$HOME/.config/wezterm/wezterm.lua"
    "nvim/.config/nvim:$HOME/.config/nvim"
)

# Counters for summary
SUCCESS_COUNT=0
FAILURE_COUNT=0
BACKUP_COUNT=0

# ============================================================
# Functions
# ============================================================

# Backup file or directory if it exists
backup_if_exists() {
    local target="$1"

    if [ -e "$target" ] || [ -L "$target" ]; then
        # Create backup directory if this is the first backup
        if [ ! -d "$BACKUP_DIR" ]; then
            mkdir -p "$BACKUP_DIR"
            echo -e "${BLUE}Creating backup directory: $BACKUP_DIR${NC}\n"
        fi

        # Determine backup path (preserve directory structure)
        local backup_path="$BACKUP_DIR$target"
        local backup_parent=$(dirname "$backup_path")

        mkdir -p "$backup_parent"

        # Copy with -L to follow symlinks (convert to real files)
        cp -rL "$target" "$backup_path"
        echo -e "${YELLOW}  → Backed up:${NC} $target"
        ((BACKUP_COUNT++))
    fi
}

# Deploy a single dotfile
deploy_one() {
    local mapping="$1"
    local source="${mapping%%:*}"
    local dest="${mapping#*:}"

    echo -e "\n${BLUE}Deploying:${NC} $source → $dest"

    # Check if source exists in repo
    if [ ! -e "$source" ]; then
        echo -e "${RED}  ✗ Source not found:${NC} $source"
        ((FAILURE_COUNT++))
        return 1
    fi

    # Backup existing file/directory
    backup_if_exists "$dest"

    # Create parent directory if needed
    local dest_parent=$(dirname "$dest")
    if [ ! -d "$dest_parent" ]; then
        mkdir -p "$dest_parent"
        echo -e "  → Created directory: $dest_parent"
    fi

    # Remove old file/directory if exists
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        rm -rf "$dest"
    fi

    # Copy new file/directory
    cp -r "$source" "$dest"
    echo -e "${GREEN}  ✓ Deployed${NC}"
    ((SUCCESS_COUNT++))
}

# ============================================================
# Main
# ============================================================

echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║  Dotfiles Deployment (with auto-backup)   ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"

# Deploy all dotfiles
for mapping in "${DOTFILES[@]}"; do
    deploy_one "$mapping" || true  # Continue on error
done

# ============================================================
# Summary
# ============================================================

echo -e "\n${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║              Deployment Summary            ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"

echo -e "\n${GREEN}✓ Successfully deployed: $SUCCESS_COUNT${NC}"

if [ $FAILURE_COUNT -gt 0 ]; then
    echo -e "${RED}✗ Failed: $FAILURE_COUNT${NC}"
fi

if [ $BACKUP_COUNT -gt 0 ]; then
    echo -e "${YELLOW}→ Files backed up: $BACKUP_COUNT${NC}"
    echo -e "\n${YELLOW}Backup location:${NC} $BACKUP_DIR"
    echo -e "${YELLOW}To restore a file:${NC} cp -r $BACKUP_DIR/path/to/file /path/to/file"
else
    echo -e "\n${BLUE}No existing files were overwritten (no backups needed)${NC}"
fi

echo -e "\n${GREEN}Deployment complete!${NC}"
