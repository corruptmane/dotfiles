# Profile file. Runs on login. Environmental variables are set here.

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$HOME/.local/bin:$HOME/.local/bin/personal"

# Default programs:
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export READER="zathura"
export FILE="lf"

# Wayland optimization
export GDK_BACKEND=wayland

# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export GRIPHOME="${XDG_CONFIG_HOME:-$HOME/.config}/grip"
export PSQLRC="${XDG_CONFIG_HOME:-$HOME/.config}/pg/psqlrc"
export PGPASSFILE="${XDG_CONFIG_HOME:-$HOME/.config}/pg/pgpass"
export PGSERVICEFILE="${XDG_CONFIG_HOME:-$HOME/.config}/pg/pg_service.conf"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export WAKATIME_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/wakatime"
export IPYTHONDIR="${XDG_CONFIG_HOME:-$HOME/.config}/jupyter"
export WGETRC="${XDG_CONFIG_HOME:-$HOME}/wgetrc"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export ATOM_HOME="${XDG_DATA_HOME:-$HOME.local/share}/atom"
export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/history"
export POETRY_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/poetry"

export PSQL_HISTORY="${XDG_CACHE_HOME:-$HOME/.cache}/pg/psql_history"
