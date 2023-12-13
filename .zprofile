# Profile file. Runs on login. Environmental variables are set here.

# set up homebrew environment
eval "$(/opt/homebrew/bin/brew shellenv)"

# git gpgsign fix
export GPG_TTY=$(tty)

# extend new binary path
export PATH="/Library/Frameworks/Python.framework/Versions/3.11/bin:$PATH:$HOME/.local/bin:$HOME/.local/bin/personal"

# default programs:
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export TERMINAL="kitty"
export FILE="lf"

# default XDG directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# cleanup ~/ directory
export PSQLRC="${XDG_CONFIG_HOME:-$HOME/.config}/pg/psqlrc"
export PGPASSFILE="${XDG_CONFIG_HOME:-$HOME/.config}/pg/pgpass"
export PGSERVICEFILE="${XDG_CONFIG_HOME:-$HOME/.config}/pg/pg_service.conf"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export WAKATIME_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/wakatime"
export IPYTHONDIR="${XDG_CONFIG_HOME:-$HOME/.config}/jupyter"

export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export POETRY_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/poetry"

export PSQL_HISTORY="${XDG_CACHE_HOME:-$HOME/.cache}/pg/psql_history"
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/npm/config"
