export FZF_DEFAULT_OPTS="
--height=60%
--layout=reverse
--inline-info
--border=sharp
--border-label=' ☉__☉  '
--info='right'
--pointer='▶'
--marker='✓'
--prompt='❯ '
--preview='echo {} && batcat --style=numbers --color=always --line-range=:500 {}'
--preview-window='right:50%:wrap:border-double'
--color=fg:#cdd6f4,hl:#f38ba8
--color=fg+:#cdd6f4,bg+:#313244,hl+:#f38ba8
--color=info:#74c7ec,prompt:#cba6f7,pointer:#94e2d5
--color=marker:#f2cdcd,spinner:#a6e3a1,header:#b4befe
--color=border:#b4befe,label:#f5c2e7
--bind='ctrl-/:toggle-preview'
--bind='ctrl-d:preview-page-down'
--bind='ctrl-u:preview-page-up'
--bind='ctrl-space:toggle+up'
--bind='alt-j:preview-down'
--bind='alt-k:preview-up'
--bind='alt-v:toggle-all'
--bind='tab:down,shift-tab:up'
--bind='ctrl-f:half-page-down'
--bind='ctrl-b:half-page-up'
--bind='ctrl-g:top'
--bind='ctrl-q:abort'
--bind='alt-e:execute(echo {} | xargs -r $EDITOR)'
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
  git_root=$(git rev-parse --show-toplevel 2>/dev/null)
  if [ -n "$git_root" ] && [ "$git_root" != "$HOME" ]; then
    rg --files --hidden --follow --glob "!.git/*" --no-ignore-global "$git_root" | while read -r file; do
      realpath --relative-to="." "$file"
    done
  else
    rg --files --hidden --follow --glob "!.git/*" --no-ignore
  fi
'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="
--preview='~/.config/zsh/fzf-preview.sh {}'
--preview-window='right:50%:wrap:border-double'
--border-label=' (◕‿◕) Find Files 📂 '
--prompt='Files ❯ '
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
--preview-window right:50%:wrap:border-rounded
--border-label=' Directories '
--prompt 'Dirs ❯ '
--bind 'ctrl-/:toggle-preview'
--bind='ctrl-p:preview-up'
--bind='ctrl-n:preview-down'
--bind='ctrl-y:accept'
"
