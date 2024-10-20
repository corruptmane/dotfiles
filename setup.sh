#!/bin/sh

# make sure we have pulled in and updated any submodules
git submodule init
git submodule update

# what directories should be installable by all users including the root user
base="npm nvim shortcuts tmux zsh"

# directories that should, or only need to be installed for a local user
useronly="kitty mako"

# run the stow command for the passed in directory ($2) in location $1
stowit() {
    usr="$1"
    app="$2"
    # -v verbose
    # -R recursive
    # -t target
    stow -v -R -t "$usr" "$app"
}

echo ""
echo "Stowing apps for user: $(whoami)"

# install apps available to local users and root
for app in $base; do
    stowit "$HOME" "$app"
done

# install only user space apps
if [ "$(whoami)" != "root" ]; then
	for app in $useronly; do
		stowit "$HOME" "$app"
	done
fi

echo ""
echo "##### ALL DONE"
