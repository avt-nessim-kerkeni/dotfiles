export FZF_DEFAULT_OPTS="
--height=~99%
--layout=reverse
--border=none
--prompt='==> '
--pointer='⟡'
--preview-window=nowrap
--preview-window=down:55%:border-double
--marker='✓'
--separator='─'
--color=fg:#cdd6f4,bg:-1
--color=fg+:#cdd6f4,bg+:#313244
--color=gutter:-1
--color=hl:#f38ba8,hl+:#f38ba8
--color=prompt:#cba6f7,pointer:#94e2d5,marker:#f2cdcd
--color=spinner:#a6e3a1,header:#b4befe,border:#585b70
--bind='ctrl-d:preview-page-down'
--bind='ctrl-u:preview-page-up'
--bind='alt-j:preview-down'
--bind='alt-k:preview-up'
--bind='alt-v:toggle-all'
--bind='tab:down,shift-tab:up'
--bind='ctrl-f:half-page-down'
--bind='ctrl-b:half-page-up'
--bind='ctrl-g:top'
--bind='ctrl-q:abort'
--bind='alt-e:execute(echo {} | xargs -r ${EDITOR:-nvim})'
--bind='ctrl-y:accept'
--bind='ctrl-p:up'
--bind='ctrl-n:down'
"

export FZF_CTRL_R_OPTS="
--no-preview
--border-label=' History '
--prompt='Shell Hist ❯ '
"

export FZF_DEFAULT_COMMAND='
rg --files --hidden --follow --glob "!.git/*" --no-ignore'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="
--preview='if [ -d {} ]; then (tree -C {}) else (bat —style=numbers —color=always —line-range :500 {}) fi'
--preview-window='down:50%:wrap:border-double'
--border-label=' (◕‿◕) Find Files 📂 '
--prompt='Files ❯ '
--layout=reverse
--inline-info
--bind='ctrl-/:toggle-preview'
--bind='ctrl-o:execute(wslview {})'
--bind='ctrl-u:preview-up'
--bind='ctrl-d:preview-down'
--bind='ctrl-y:accept'
"

export FZF_ALT_C_COMMAND="eza --color=always --all --only-dirs --sort=modified --icons"
export FZF_ALT_C_OPTS="
--ansi
--preview 'eza --tree --level=2 --color=always --icons -- {}'
--preview-window down:50%:wrap:border-double
--border-label=' Directories '
--prompt 'Dirs ❯ '
--bind 'ctrl-/:toggle-preview'
--bind='ctrl-p:preview-up'
--bind='ctrl-n:preview-down'
--bind='ctrl-y:accept'
"
