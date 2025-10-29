# Dotfiles Management

**Super simple, maximum safety.** Two bash scripts with automatic backups, no symlinks.

---

## Prerequisites

### CachyOS/Arch Installation

```bash
# Core tools
sudo pacman -S zsh wezterm neovim git rsync

# Powerlevel10k theme
yay -S zsh-theme-powerlevel10k-git

# Set Zsh as default shell
chsh -s $(which zsh)
```

---

## Usage

### Dotfiles geändert? → Ins Repo kopieren

```bash
./collect.sh
```

---

## Safety - Automatic Backups

**Every time** you run `deploy.sh`, timestamped backups are created:

```
~/.dotfiles-backup/
├── 20251029_143052/    ← Backup vom 29.10.2025 um 14:30:52
│   ├── .zshrc
│   ├── .p10k.zsh
│   └── .config/
│       ├── nvim/
│       └── wezterm/
└── 20251028_091234/    ← Vorheriges Backup
```

`collect.sh` checks for uncommitted changes before overwriting.

---

## What Gets Synced

| Source (Home)               | Destination (Repo)       |
|-----------------------------|--------------------------|
| `~/.zshrc`                  | `zsh/.zshrc`             |
| `~/.p10k.zsh`               | `p10k/.p10k.zsh`         |
| `~/.config/wezterm/`        | `wezterm/`               |
| `~/.config/nvim/`           | `nvim/.config/nvim/`     |

**Note:** Nvim lock files (lazy-lock.json, lazyvim.json, .neoconf.json) are excluded.

---

## Troubleshooting

**Q: "collect.sh says I have uncommitted changes"**
A: Commit or stash your changes first, or confirm to proceed.

**Q: "Where are my backups?"**
A: `~/.dotfiles-backup/` - sorted by date.
