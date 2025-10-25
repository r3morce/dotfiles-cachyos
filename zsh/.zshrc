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
alias lsl='ls -la'
alias sl="wezterm cli split-pane --left"
alias sb="wezterm cli split-pane --bottom"
alias nt="wezterm cli set-tab-title"
alias gs="git status"
alias lg="lazygit"
alias v="nvim"
# alias cat="bat"
alias readlink="readlink -f"  # Show absolute path of symlink target
alias pu="sudo pacman -Run"
alias pi="sudo pacman -S"
alias ps="pacman -Ss"
alias open='xdg-open'

# Useful Functions
mkcd() { mkdir -p "$1" && cd "$1"; }

# Check if something is a symlink and show target
islink() {
    if [ $# -eq 0 ]; then
        echo "Usage: islink <file_or_directory>"
        return 1
    fi
    
    for item in "$@"; do
        if [ -L "$item" ]; then
            echo "🔗 $item -> $(readlink "$item")"
        else
            echo "📄 $item (not a symlink)"
        fi
    done
}

# Initialize tools
eval "$(zoxide init zsh)"

# Load plugins directly
source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Starship prompt
eval "$(starship init zsh)"

# Transient prompt (p10k-style) - shows only minimal prompt after command execution
zle-line-init() {
    emulate -L zsh

    [[ $CONTEXT == start ]] || return 0

    while true; do
        zle .recursive-edit
        local -i ret=$?
        [[ $ret == 0 && $KEYS == $'\4' ]] || break
        [[ -o ignore_eof ]] || exit 0
    done

    local saved_prompt=$PROMPT
    local saved_rprompt=$RPROMPT
    PROMPT='%F{green}❯%f '
    RPROMPT=''
    zle .reset-prompt
    PROMPT=$saved_prompt
    RPROMPT=$saved_rprompt

    if (( ret )); then
        zle .send-break
    else
        zle .accept-line
    fi
    return ret
}

zle -N zle-line-init
