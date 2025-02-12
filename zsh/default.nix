# zsh/default.nix
{ config, pkgs, ... }:

{
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
      railway-local ="RAILWAY_ENV=dev ~/Projects/cli/target/release/railway";
    };

    initExtra = ''
      # Enable case-insensitive completion
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

      eval "$(direnv hook zsh)"
    '';
  };
}
