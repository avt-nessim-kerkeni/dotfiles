zstyle ':fzf-tab:complete:*:*' fzf-preview \
'if [[ -f ${(Q)realpath} ]]; then
  batcat --color=always --style=numbers,changes --line-range=:500 ${(Q)realpath}
elif [[ -d ${(Q)realpath} ]]; then
  eza --color=always --header --icons --tree --level=2 ${(Q)realpath}
else
  echo ${(Q)realpath}
fi'
zstyle ':fzf-tab:complete:*' fzf-preview 'eval echo {1}'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:*' fzf-flags --height=75% --layout=reverse --inline-info --color=fg:1,fg+:2
zstyle ':fzf-tab:*' use-fzf-default-opts yes
zstyle ':fzf-tab:*' switch-group '<' '>'

fzf-tab-preview() {
  local file="$1"
  if [[ -d "$file" ]]; then
    # Directory preview with eza
    eza --tree --level=2 --color=always --icons --git-ignore "$file" 2>/dev/null || \
    ls -la --color=always "$file" 2>/dev/null
  elif [[ -f "$file" ]]; then
    # File preview with bat
    if command -v batcat &>/dev/null; then
      batcat --color=always --style=numbers,changes --line-range=:500 "$file" 2>/dev/null
    elif command -v bat &>/dev/null; then
      bat --color=always --style=numbers,changes --line-range=:500 "$file" 2>/dev/null
    else
      head -n 100 "$file" 2>/dev/null
    fi
  else
    # Fallback for other types
    file "$file" 2>/dev/null || echo "No preview available"
  fi
}

# Git completions with git show/log preview
zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
  'git diff --color=always $word 2>/dev/null || git diff --cached --color=always $word 2>/dev/null'

zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
  'git show --color=always $word 2>/dev/null'

zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
  'git show --color=always $word 2>/dev/null'

zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
  'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $word 2>/dev/null'

# Docker completions
zstyle ':fzf-tab:complete:docker-(run|images|ps|exec):*' fzf-preview \
  'docker inspect $word 2>/dev/null | jq -C . 2>/dev/null || docker inspect $word 2>/dev/null'

# Process completions (kill, killall, etc.)
zstyle ':fzf-tab:complete:(kill|ps):argument-rest:*' fzf-preview \
  'ps -f -p $word 2>/dev/null'

# Man page completions
zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview \
  'man $word 2>/dev/null | head -n 50'

# Package manager completions
zstyle ':fzf-tab:complete:apt:*' fzf-preview \
  'apt show $word 2>/dev/null || apt-cache show $word 2>/dev/null'

zstyle ':fzf-tab:complete:yum:*' fzf-preview \
  'yum info $word 2>/dev/null'

zstyle ':fzf-tab:complete:dnf:*' fzf-preview \
  'dnf info $word 2>/dev/null'

# SSH completions
zstyle ':fzf-tab:complete:ssh:*' fzf-preview \
  'ping -c 1 $word 2>/dev/null || echo "Host: $word"'

# Environment variables
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview \
  'echo ${(P)word} 2>/dev/null || echo "Variable: $word"'

# === DISABLE PREVIEW FOR CERTAIN COMPLETIONS ===

# Disable preview for simple options/flags
zstyle ':fzf-tab:complete:*:options' fzf-preview ''
zstyle ':fzf-tab:complete:*:argument-1' fzf-preview ''

# Disable preview for cd when showing history
zstyle ':fzf-tab:complete:cd:*' fzf-preview \
  'eza --tree --level=2 --color=always --icons "$realpath" 2>/dev/null || ls -la --color=always "$realpath" 2>/dev/null'

# === PERFORMANCE OPTIMIZATIONS ===

# Limit preview for large directories
zstyle ':fzf-tab:complete:*:*' fzf-preview \
  '[[ -d "$realpath" ]] && [[ $(find "$realpath" -maxdepth 1 | wc -l) -gt 100 ]] && echo "Directory too large for preview" || fzf-tab-preview "$realpath"'

# === CUSTOM GROUPS AND SORTING ===

# Group different types of completions
zstyle ':fzf-tab:complete:*:*' fzf-preview-group \
  'files:Files' \
  'directories:Directories' \
  'commands:Commands' \
  'options:Options' \
  'git:Git' \
  'processes:Processes'

# Sort order for groups
zstyle ':fzf-tab:complete:*' group-order \
  'files' \
  'directories' \
  'commands' \
  'options' \
  'git' \
  'processes'

# === ADDITIONAL ENHANCEMENTS ===

# Show file type icons if available
zstyle ':fzf-tab:complete:*' show-group brief

# Accept completion with enter
zstyle ':fzf-tab:*' accept-line enter

# Fuzzy matching
zstyle ':fzf-tab:*' query-string prefix input first

# Custom header for different completion types
zstyle ':fzf-tab:complete:cd:*' extra-opts --header='Select Directory'
zstyle ':fzf-tab:complete:git:*' extra-opts --header='Git Operations'
zstyle ':fzf-tab:complete:docker:*' extra-opts --header='Docker Resources'

# === FALLBACK CONFIGURATIONS ===

# Default behavior for unmatched completions
zstyle ':fzf-tab:complete:*' default-command \
  'echo "No specific preview available for: $word"'

# Timeout for preview generation (prevent hanging)
zstyle ':fzf-tab:*' preview-timeout 1000

