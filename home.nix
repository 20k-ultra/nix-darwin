{ config, pkgs, ... }:

{
  home.username = "mig";
  home.homeDirectory = "/Users/mig";
  
  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Import configurations
  imports = [ 
    ./firefox 
    ./nodejs
    ./zsh
    ./wezterm
  ];

  programs.git = {
    enable = true;
    userName = "20k-ultra";
    userEmail = "3946250+20k-ultra@users.noreply.github.com";
    extraConfig = {
      gpg.format = "ssh";
      commit.gpgsign = false;
      user.signingkey = "~/.ssh/id_ed25519";
    };
  };

  home.packages = with pkgs; [
    git
    google-cloud-sdk
    gnumake
    tree
    discord
    gnupg
    jq
    btop
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  home.stateVersion = "23.05";
}
