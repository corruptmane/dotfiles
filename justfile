nix-sync:
    sudo darwin-rebuild switch --flake ~/.config/nix#mini

nix-self-update:
    sudo nix flake update --flake ~/.config/nix

nix-full-update: nix-self-update nix-sync

colima-start profile:
    colima start -p {{ profile }}

colima-stop profile:
    colima stop -p {{ profile }}
