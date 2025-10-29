#!/usr/bin/env bash
# setup.sh - Create directory structure for dotfiles repo
# Run this once to set up the basic folder structure

set -e

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== Setting up dotfiles directory structure ===${NC}\n"

# Create directories
DIRS=(
    "zsh"
    "p10k"
    "wezterm"
    "nvim/.config/nvim"
)

for dir in "${DIRS[@]}"; do
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
        echo -e "${GREEN}✓${NC} Created: $dir"
    else
        echo -e "  Already exists: $dir"
    fi
done

echo -e "\n${GREEN}Directory structure created!${NC}"
echo -e "\nNext steps:"
echo -e "  1. Run ${BLUE}./collect.sh${NC} to copy your current dotfiles to this repo"
echo -e "  2. Review the copied files"
echo -e "  3. Commit and push to git"
