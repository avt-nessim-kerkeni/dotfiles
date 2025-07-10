# Only in interactive shell
[[ $- != *i* ]] && return

setopt AUTOCD             # AutoCd
setopt HIST_IGNORE_DUPS   # No duplicate history entries
setopt HIST_IGNORE_SPACE  # Don't save commands starting with space
setopt APPEND_HISTORY     # Append history, don't overwrite
setopt INC_APPEND_HISTORY # Add to history immediately
setopt SHARE_HISTORY      # Share history across terminals

# History
HISTFILE="$XDG_DATA_HOME/zsh/history"
HISTSIZE=10000
SAVEHIST=10000

# Prompt
fpath+="${XDG_CONFIG_HOME:-$HOME/.config}/zsh/pure"
autoload -U promptinit
promptinit
prompt pure

export LS_COLORS="$(vivid generate catppuccin-mocha)"

source "${ZDOTDIR}"/fzf_config.zsh
[[ -f "/usr/share/doc/fzf/examples/completion.zsh" ]] && source "/usr/share/doc/fzf/examples/completion.zsh"
[[ -f "/usr/share/doc/fzf/examples/key-bindings.zsh" ]] && source "/usr/share/doc/fzf/examples/key-bindings.zsh"

source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh"
source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/functions/fzf_tab_config.zsh"
source "${XDG_CONFIG_HOME:-$HOME/.config}/zsh/functions/zsh_init.zsh"

source "${XDG_CONFIG_HOME:-${HOME}/.config}/zsh/plugins/catppuccin_mocha-zsh-syntax-highlighting.zsh"
source "${XDG_CONFIG_HOME:-${HOME}/.config}/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh"

source "${ZDOTDIR}"/aliases.zsh
source "${ZDOTDIR}"/functions/functions.zsh

# Environment variables
export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "${NVM_DIR}/nvm.sh" ] && \. "${NVM_DIR}/nvm.sh"

eval "$(zoxide init zsh)"
