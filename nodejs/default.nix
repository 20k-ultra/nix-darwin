{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Node.js (LTS version)
    nodejs_22

    # PNPM package manager
    nodePackages_latest.pnpm

    # Common global tools you might want
    nodePackages_latest.typescript
    nodePackages_latest.typescript-language-server
  ];

  # Environment variables for Node.js and PNPM
  home.sessionVariables = {
    # Specify global pnpm store directory
    PNPM_HOME = "${config.home.homeDirectory}/.local/share/pnpm";
    # Configure npm global directory to avoid permission issues
    NPM_CONFIG_PREFIX = "${config.home.homeDirectory}/.npm-global";
  };

  # Create necessary directories
  home.file.".local/share/pnpm/.keep".text = "";
  home.file.".npm-global/.keep".text = "";

  # Add pnpm configuration
  home.file.".npmrc".text = ''
    prefix=${config.home.homeDirectory}/.npm-global
    store-dir=${config.home.homeDirectory}/.local/share/pnpm/store
  '';
}
