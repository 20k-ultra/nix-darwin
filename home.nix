{ config, pkgs, ... }:

{
  home.username = "mig";
  home.homeDirectory = "/Users/mig";
  
  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Import Firefox configuration
  imports = [ 
    ./firefox 
    ./nodejs
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      # Vi keybindings
      {
        name = "zsh-vi-mode";
        file = "./share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        src = pkgs.zsh-vi-mode;
      }
    ];

    shellAliases = rec {
      gs      = "git status";
      dotfiles = "cd ~/.config/nix";
    };

    initExtra = ''
      # Enable case-insensitive completion
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

      eval "$(direnv hook zsh)"
    '';
  };

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
