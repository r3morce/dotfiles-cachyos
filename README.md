# CachyOS Dotfiles

Configuration files for my CachyOS setup.

## Prerequisites

Before installing the dotfiles, make sure you have the required tools installed:

### Install Zsh
```bash
sudo pacman -S zsh
```

Set Zsh as your default shell:
```bash
chsh -s $(which zsh)
```

### Install Wezterm
```bash
sudo pacman -S wezterm
```

### Install Starship
```bash
sudo pacman -S starship
```

Or install all at once:
```bash
sudo pacman -S zsh wezterm starship
chsh -s $(which zsh)
```

## Installation

To install these dotfiles on a new machine, copy the files to the following locations:

### Zsh Configuration
- **Source**: `zsh/.zshrc`
- **Destination**: `~/.zshrc`

```bash
cp zsh/.zshrc ~/.zshrc
```

### Wezterm Configuration
- **Source**: `wezterm/wezterm.lua`
- **Destination**: `~/.config/wezterm/wezterm.lua`

```bash
mkdir -p ~/.config/wezterm
cp wezterm/wezterm.lua ~/.config/wezterm/
```

### Starship Configuration
- **Source**: `starship/starship.toml`
- **Destination**: `~/.config/starship.toml`

```bash
cp starship/starship.toml ~/.config/
```

## Quick Install

Run all commands at once:

```bash
cp zsh/.zshrc ~/.zshrc
mkdir -p ~/.config/wezterm
cp wezterm/wezterm.lua ~/.config/wezterm/
cp starship/starship.toml ~/.config/
```
