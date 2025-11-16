{
  description = "(Temporarely experimental) Corrupt nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, nix-homebrew, homebrew-core, homebrew-cask, ... }:
  let
    configuration = { pkgs, config, ... }: {

      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
	pkgs.neovim
	pkgs.zsh
	pkgs.ffmpeg
	pkgs.mkalias
	pkgs.tmux
	pkgs.just
	pkgs.iina
	pkgs.obsidian
	pkgs.bitwarden-desktop
	pkgs.bitwarden-cli
	pkgs.keepassxc
	pkgs.uv
	pkgs.bun
	pkgs.go
	pkgs.rustup
	pkgs.opentofu
	pkgs.ansible
	pkgs.lazygit
	pkgs.lazydocker
	pkgs.yazi
	pkgs.zoxide
	pkgs.zoom-us
	pkgs.raycast
	pkgs.chatterino7
	pkgs.opencode
	pkgs.claude-code
	pkgs.wakatime-cli
	pkgs.pre-commit
	pkgs.fzf
	pkgs.ripgrep
	pkgs.fd
	pkgs.bat
	pkgs.aerospace
	pkgs.colima
	pkgs.docker-client
	pkgs.docker-compose
	pkgs.docker-buildx
	pkgs.kubectl
	pkgs.k9s
	pkgs.natscli
	pkgs.telegram-desktop
	pkgs.spotify
	pkgs.qbittorrent
	pkgs.btop
	pkgs.htop
	pkgs.discord
	pkgs.fastfetch
	pkgs.rsync
	pkgs.stow
	pkgs.p7zip
	pkgs.unzip
	pkgs.tree
	pkgs.typst
	# LSPs, DAPs, formatters, linters etc.
	pkgs.lua-language-server
	pkgs.stylua
	pkgs.terraform-ls
	pkgs.tofu-ls
	pkgs.ruff
	pkgs.mypy
	pkgs.pyright
	pkgs.gopls
	pkgs.sqls
	pkgs.vscode-json-languageserver
	pkgs.typstyle
	pkgs.tinymist
	pkgs.bash-language-server
	pkgs.yaml-language-server
	pkgs.nginx-language-server
	pkgs.marksman
	pkgs.just-lsp
	pkgs.tree-sitter
      ];

      homebrew = {
	enable = true;
	brews = [
	  "mas"
	  "coreutils"
	  "gawk"
	  "grep"
	  "gnu-sed"
	  "gnu-tar"
	  "make"
	  "zip"
	  "gnupg"
	  "pinentry-mac"
	  "zsh-autosuggestions"
	  "zsh-syntax-highlighting"
	];
	casks = [
	  "ghostty"
	  "obs"
	  "karabiner-elements"
	  "syncthing-app"
	];
	masApps = {
	  "Spark" = 1176895641;
	  "Dropover" = 1355679052;
	  "Velja" = 1607635845;
	};
	onActivation = {
	  cleanup = "zap";
	  autoUpdate = true;
	  upgrade = true;
	};
      };

      fonts.packages = [
	pkgs.nerd-fonts.jetbrains-mono
      ];

      system.defaults = {
	dock.autohide = true;
	finder.FXPreferredViewStyle = "clmv";
	loginwindow.GuestEnabled = false;
	NSGlobalDomain.AppleICUForce24HourTime = true;
	NSGlobalDomain.AppleInterfaceStyle = "Dark";
	NSGlobalDomain.KeyRepeat = 2;
      };

      security.sudo.extraConfig = ''
Defaults timestamp_timeout=30
Defaults !tty_tickets
      '';

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      system.primaryUser = "corrupt";

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#mini
    darwinConfigurations."mini" = nix-darwin.lib.darwinSystem {
      modules = [
	configuration
	nix-homebrew.darwinModules.nix-homebrew
	{
	  nix-homebrew = {
	    # Install homebrew under the default prefix
	    enable = true;

	    # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
	    enableRosetta = true;

	    # User owning the Homebrew prefix
	    user = "corrupt";

	    taps = {
	      "homebrew/homebrew-core" = homebrew-core;
	      "homebrew/homebrew-cask" = homebrew-cask;
	    };

	    # Optional: Enable fully-declarative tap management
	    # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`
	    mutableTaps = false;
	  };
	}
	# Optional: align homebrew taps config with nix-homebrew
	({config, ...}: {
	  homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
	})
      ];
    };
  };
}
