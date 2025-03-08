{ pkgs, ... }: {

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages =
    [ pkgs.vim
      pkgs.discord  # Add Discord to system packages
    ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  programs.zsh.enable = true;
  
  system.build.applications = pkgs.lib.mkForce (pkgs.buildEnv {
    name = "applications";
    paths = [ 
      pkgs.firefox-dev 
      pkgs.discord  # Add Discord to the applications paths
    ];
    pathsToLink = "/Applications";
  });

  # Dock and Mission Control settings
  system.defaults = {
    dock = {
      autohide = true;  # Automatically hide the Dock
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
