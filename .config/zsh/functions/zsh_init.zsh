function zvm_after_init() {
    bindkey -M vicmd ',' up-history
    bindkey -M vicmd ';' down-history

    bindkey -M viins '^[[1;5D' backward-word
    bindkey -M viins '^[[1;5C' forward-word

    bindkey -M viins '^N' vi-cmd-mode

    bindkey -M viins '^L' clear-screen

    bindkey '^R' fzf-history-widget
    bindkey '^@' autosuggest-accept
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd zvm_after_init
