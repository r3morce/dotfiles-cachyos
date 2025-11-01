#!/bin/bash
# prepare.sh - Prepare home directory for stowing dotfiles

set -e

PACKAGES="zsh p10k nvim wezterm"

echo "Preparing home directory for stowing..."

# Clean up any broken symlinks in backup directory first
if [ -d "$HOME/.dotfiles-backup" ]; then
    echo "Cleaning up broken symlinks in backup directory..."
    find "$HOME/.dotfiles-backup" -type l -delete 2>/dev/null || true
fi

for pkg in $PACKAGES; do
    case $pkg in
        zsh) target="$HOME/.zshrc" ;;
        p10k) target="$HOME/.p10k.zsh" ;;
        nvim) target="$HOME/.config/nvim" ;;
        wezterm) target="$HOME/.config/wezterm" ;;
    esac
    
    if [ -L "$target" ]; then
        echo "Removing symlink: $target"
        rm "$target"
    elif [ -f "$target" ]; then
        echo "Backing up file: $target -> ${target}.bak"
        mv "$target" "${target}.bak"
    elif [ -d "$target" ]; then
        echo "Backing up directory: $target -> ${target}.bak"
        mv "$target" "${target}.bak"
    else
        echo "No conflict: $target (good)"
    fi
done

echo "Preparation complete. You can now run: stow --target=\$HOME $PACKAGES"