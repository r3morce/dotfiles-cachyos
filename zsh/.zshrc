# History configuration
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Basic zsh completion
autoload -U compinit && compinit

# Path configuration
export PATH="$HOME/.local/bin:$PATH"

# Better editor integration
export VISUAL=nvim
export EDITOR=nvim
export BROWSER=firefox

# Aliases
alias p='cd ~/Documents/projects/'
alias s='cd ~/Documents/sandbox/'
alias ls='eza --icons'
alias ll='eza --icons -l'
alias la='eza --icons -la'
alias sl="wezterm cli split-pane --left"
alias sb="wezterm cli split-pane --bottom"
alias nt="wezterm cli set-tab-title"
alias gs="git status"
alias open='xdg-open'

# Useful Functions
mkcd() { mkdir -p "$1" && cd "$1"; }

# Initialize tools
eval "$(zoxide init zsh)"

# Load plugins directly
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# p10k
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
