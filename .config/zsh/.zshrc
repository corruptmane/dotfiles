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

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shortcutrc"

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

# Specific poetry completions
fpath+=~/.zfunc

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

# Use lf to switch directories and bind it to ctrl-o
lfcd() {
	tmp="$(mktemp)"
	lf -last-dir-path="$tmp" "$@"
	if [ -f "$tmp" ]; then
		dir="$(cat "$tmp")"
		rm -f "$tmp"
		[ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
	fi
}
bindkey -s '^o' 'lfcd\n'

# fzf integration
# ---------
if [[ ! "$PATH" == */opt/homebrew/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/opt/homebrew/opt/fzf/bin"
fi
# auto-completion
source "/opt/homebrew/opt/fzf/shell/completion.zsh"
# key bindings
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"
# different ssh-hosts options
__fzf_list_hosts() {
setopt localoptions nonomatch
command cat <(command tail -n +1 ~/.ssh/config ~/.ssh/config.d/* /etc/ssh/ssh_config 2> /dev/null | command grep -i '^\s*host\? ' | awk '{for (i = 2; i <= NF; i++) print $1 " " $i}' | command grep -v '[*?%]') \
  <(tr ',' '\n' | tr -d '[' | awk '{ print $1 " " $1 }') \
  <(command grep -Fv '0.0.0.0' | command sed 's/#.*//') |
  awk '{for (i = 2; i <= NF; i++) print $i}' | sort -u
}
# ---------

# bat integration
# ---------
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}
# ---------

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load zsh-syntax-highlighting and zsh-autosuggestions; should be last.
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/nvim/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
