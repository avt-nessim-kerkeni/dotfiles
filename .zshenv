. "$HOME/.cargo/env"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"

# Minimal PATH setup (zshenv is loaded in non-interactive mode too)
export PATH="$HOME/.local/bin:/usr/local/bin:$PATH"

