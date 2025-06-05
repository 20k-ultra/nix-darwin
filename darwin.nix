{ pkgs, ... }: {

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [
      pkgs.vim
      pkgs.discord
      pkgs.go
    ];

  # allows Determinate to handle Nix insallation
  nix.enable = false;

  # Enable alternative shell support in nix-darwin.
  programs.zsh.enable = true;

  # Set primary user for system defaults
  system.primaryUser = "mig";

  system.build.applications = pkgs.lib.mkForce (pkgs.buildEnv {
    name = "applications";
    paths = [
      pkgs.firefox-devedition # Use standard Firefox Developer Edition
      pkgs.discord
    ];
    pathsToLink = "/Applications";
  });

  # Dock and Mission Control settings
  system.defaults = {
    dock = {
      autohide = true; # Automatically hide the Dock
      mru-spaces = false; # Prevent automatic rearrangement of spaces
    };
    NSGlobalDomain = {
      # Disable natural scrolling
      "com.apple.swipescrolldirection" = false;
    };
    trackpad = {
      # Enable tap-to-click
      Clicking = true;
    };
    finder = {
      AppleShowAllExtensions = true;
    };
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  users.users.mig = {
    name = "mig";
    home = "/Users/mig";
  };
}

