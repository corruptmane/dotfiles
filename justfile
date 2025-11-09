nix-sync:
	sudo darwin-rebuild switch --flake ./nix#mini

nix-self-update:
	sudo nix flake update --flake ./nix
