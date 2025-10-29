#!/usr/bin/env bash
# collect.sh - Collect dotfiles from home directory to repo
# Checks git status and warns about uncommitted changes

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

# Dotfiles to collect (source:destination)
DOTFILES=(
    "$HOME/.zshrc:zsh/.zshrc"
    "$HOME/.p10k.zsh:p10k/.p10k.zsh"
    "$HOME/.config/wezterm/wezterm.lua:wezterm/wezterm.lua"
    "$HOME/.config/nvim:nvim/.config/nvim"
)

# Files to exclude when syncing nvim
NVIM_EXCLUDE=(
    "lazy-lock.json"
    "lazyvim.json"
    ".neoconf.json"
)

# Counters for summary
SUCCESS_COUNT=0
FAILURE_COUNT=0

# ============================================================
# Functions
# ============================================================

# Check git status and warn about uncommitted changes
check_git_status() {
    if [ ! -d .git ]; then
        echo -e "${YELLOW}Warning: Not in a git repository${NC}"
        return 0
    fi

    if ! git diff --quiet 2>/dev/null || ! git diff --cached --quiet 2>/dev/null; then
        echo -e "${YELLOW}╔════════════════════════════════════════════╗${NC}"
        echo -e "${YELLOW}║            UNCOMMITTED CHANGES             ║${NC}"
        echo -e "${YELLOW}╚════════════════════════════════════════════╝${NC}"
        echo -e "${YELLOW}You have uncommitted changes in this repo.${NC}"
        echo -e "${YELLOW}Collecting now will overwrite these files!${NC}\n"

        git status --short

        echo -e "\n${YELLOW}Do you want to continue? (y/N)${NC} "
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            echo -e "${RED}Aborted.${NC}"
            exit 1
        fi
        echo ""
    fi
}

# Collect a single dotfile
collect_one() {
    local mapping="$1"
    local source="${mapping%%:*}"
    local dest="${mapping#*:}"

    echo -e "\n${BLUE}Collecting:${NC} $source → $dest"

    # Check if source exists in home directory
    if [ ! -e "$source" ]; then
        echo -e "${YELLOW}  ! Source not found (skipping):${NC} $source"
        return 0
    fi

    # Create destination parent directory if needed
    local dest_parent=$(dirname "$dest")
    if [ ! -d "$dest_parent" ]; then
        mkdir -p "$dest_parent"
        echo -e "  → Created directory: $dest_parent"
    fi

    # Special handling for nvim directory (use rsync with exclusions)
    if [[ "$source" == *"/.config/nvim" ]]; then
        # Build rsync exclude arguments
        local exclude_args=()
        for excluded_file in "${NVIM_EXCLUDE[@]}"; do
            exclude_args+=("--exclude=$excluded_file")
        done

        # Sync with rsync (--delete removes files not in source)
        if rsync -av --delete "${exclude_args[@]}" "$source/" "$dest/" >/dev/null; then
            echo -e "${GREEN}  ✓ Synced (nvim with exclusions)${NC}"
            ((SUCCESS_COUNT++))
        else
            echo -e "${RED}  ✗ Failed to sync${NC}"
            ((FAILURE_COUNT++))
        fi
    else
        # Regular copy for other files
        cp -r "$source" "$dest"
        echo -e "${GREEN}  ✓ Collected${NC}"
        ((SUCCESS_COUNT++))
    fi
}

# ============================================================
# Main
# ============================================================

echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║         Dotfiles Collection                ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}\n"

# Check git status first
check_git_status

# Collect all dotfiles
for mapping in "${DOTFILES[@]}"; do
    collect_one "$mapping" || true  # Continue on error
done

# ============================================================
# Summary
# ============================================================

echo -e "\n${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║            Collection Summary              ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"

echo -e "\n${GREEN}✓ Successfully collected: $SUCCESS_COUNT${NC}"

if [ $FAILURE_COUNT -gt 0 ]; then
    echo -e "${RED}✗ Failed: $FAILURE_COUNT${NC}"
fi

echo -e "\n${YELLOW}Next steps:${NC}"
echo -e "  1. Review changes: ${BLUE}git diff${NC}"
echo -e "  2. Commit changes: ${BLUE}git add . && git commit -m 'Update dotfiles'${NC}"
echo -e "  3. Push to remote:  ${BLUE}git push${NC}"

echo -e "\n${GREEN}Collection complete!${NC}"
