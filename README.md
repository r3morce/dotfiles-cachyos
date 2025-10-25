# CachyOS Dotfiles

Configuration files for my CachyOS setup.

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
