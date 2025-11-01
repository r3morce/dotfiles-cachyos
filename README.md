# Dotfiles Management with GNU Stow

**Simple, clean, and portable dotfiles using GNU Stow and symlinks.**

---

## Prerequisites

### CachyOS/Arch Installation

```bash
# Core tools
sudo pacman -S zsh wezterm neovim git stow

# Powerlevel10k theme
yay -S zsh-theme-powerlevel10k-git

# Set Zsh as default shell
chsh -s $(which zsh)
```

---

## Setup

```bash
# Clone and navigate to dotfiles
git clone https://github.com/r3morce/dotfiles-cachyos.git dotfiles-cachyos
cd dotfiles-cachyos
```

---

## Installation

```bash
stow --target=$HOME zsh p10k nvim wezterm
```

---

## Overview

GNU Stow creates symbolic links from your home directory to files in this repository:

| Package | Source (Repo) | Target (Home) |
|---------|---------------|---------------|
| `zsh` | `zsh/.zshrc` | `~/.zshrc` |
| `p10k` | `p10k/.p10k.zsh` | `~/.p10k.zsh` |
| `nvim` | `nvim/.config/nvim/` | `~/.config/nvim/` |
| `wezterm` | `wezterm/wezterm.lua` | `~/.config/wezterm/wezterm.lua` |
