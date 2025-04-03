# Oh My Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-substring-search
    fzf
)

# Enable Pure Prompt
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure

# FZF Configuration
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d . $HOME"

# Preview with bat
export FZF_DEFAULT_OPTS="--preview 'bat --color=always --style=numbers --line-range=:500 {}'"

# FZF Key Bindings
source /usr/share/fzf/shell/key-bindings.zsh

# Enhanced History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS

# Aliases for FZF Enhanced Workflow
alias fcd='cd $(fd -t d | fzf)'
alias fkill='kill $(ps aux | fzf | awk "{print \$2}")'
alias fvim='vim $(fzf)'

# Large History Browser
fh() {
    print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

function z() {
	zoxide "$@"
}
# Auto-complete and suggestions
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
bindkey '^ ' autosuggest-accept

eval "$(zoxide init zsh)"

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

unalias ls 2>/dev/null
function ls() {
	eza --icons --color=auto -F "$@"
}
alias lt="ls --icons --tree --color=auto -F"
compdef ls=ls

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
