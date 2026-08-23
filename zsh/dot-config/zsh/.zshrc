# Enable colors and change prompt:
autoload -U colors && colors
setopt autocd

# Enable VCS to add to prompt
autoload -Uz add-zsh-hook vcs_info
setopt prompt_subst

add-zsh-hook precmd vcs_info

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       '(%b%u%c) '
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c) '

# Change Prompt
PROMPT='%B%{$fg[cyan]%}%~ %F{red}${vcs_info_msg_0_}%f%b> '

# Load aliases if exists.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit -d ~/.cache/zsh/zcompdump-$ZSH_VERSION
_comp_options+=(globdots)		# Include hidden files.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5c6370,bg=bold"

# vi mode
bindkey -v
export KEYTIMEOUT=1

# tmux fix
bindkey -r "^A"

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] ||
		[[ $1 = 'block' ]]; then
		echo -ne '\e[1 q'
	elif [[ ${KEYMAP} == main ]] ||
		[[ ${KEYMAP} == viins ]] ||
		[[ ${KEYMAP} == '' ]] ||
		[[ $1 = 'beam' ]]; then
		echo -ne '\e[5 q'
	fi
}

zle -N zle-keymap-select

zle-line-init() {
	zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
	echo -ne '\e[5 q'
}

zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() {echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

## fzf integration
# ---------

source <(fzf --zsh)

# ---------

## bat integration
# ---------

alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}

# ---------

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load zoxide
eval "$(zoxide init --cmd cd zsh)"

## Load k8s-related completions
# ---------

# Load kubectl completion
if command -v kubectl >/dev/null 2>&1; then
	source <(kubectl completion zsh)
fi

# Load kubectl-cnpg completion
if command -v kubectl-cnpg >/dev/null 2>&1; then
	source <(kubectl-cnpg completion zsh)
fi

# Load flux completion
if command -v flux >/dev/null 2>&1; then
	source <(flux completion zsh)
fi

# Load helm completion
if command -v helm >/dev/null 2>&1; then
	source <(helm completion zsh)
fi

# Load talosctl completion
if command -v talosctl >/dev/null 2>&1; then
	source <(talosctl completion zsh)
fi

# Load cilium completion
if command -v cilium >/dev/null 2>&1; then
	source <(cilium completion zsh)
fi

# ---------

# Load various plugins; zsh-syntax-highlighting and zsh-autosuggestions should be last.
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
