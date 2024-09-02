# Profile file. Runs on login. Environmental variables are set here.

# default XDG directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# PATH
export PATH="$PATH:${XDG_DATA_HOME:-$HOME/.local/share}/bin:${XDG_DATA_HOME:-$HOME/.local/share}/cargo/bin"

# git gpgsign fix
export GPG_TTY=$(tty)

# default programs:
export EDITOR="nvim"
export SUDO_EDITOR="nvim"
export TERMINAL="kitty"
export FILE="lf"
export BROWSER="zen-browser"

# dark theme
export GTK_THEME="Adwaita:dark"
export GTK2_RC_FILES="/usr/share/themes/Adwaita/gtk-2.0/gtkrc"
export QT_STYLE_OVERRIDE="Adwaita-Dark"

# cleanup ~/ directory
export PSQLRC="${XDG_CONFIG_HOME:-$HOME/.config}/pg/psqlrc"
export PGPASSFILE="${XDG_CONFIG_HOME:-$HOME/.config}/pg/pgpass"
export PGSERVICEFILE="${XDG_CONFIG_HOME:-$HOME/.config}/pg/pg_service.conf"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export WAKATIME_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/wakatime"
export IPYTHONDIR="${XDG_CONFIG_HOME:-$HOME/.config}/jupyter"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/npm/config"

export GOPATH="${XDG_DATA_HOME:-$HOME/.local/share}/go"
export GNUPGHOME="${XDG_DATA_HOME:-$HOME/.local/share}/gnupg"
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
export POETRY_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/poetry"

export PSQL_HISTORY="${XDG_CACHE_HOME:-$HOME/.cache}/pg/psql_history"
export HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
export LESSHISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/less/history"
export PYTHONCACHEPREFIX="${XDG_CACHE_HOME:-$HOME/.cache}/python"
export PYTHONDONTWRITEBYTECODE=1

# If running from tty1 start sway
[ "$(tty)" = "/dev/tty1" ] && exec dbus-run-session sway
