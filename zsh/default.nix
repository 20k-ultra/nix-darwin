{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Add any aliases you want
    shellAliases = {
      ll = "ls -la";
      la = "ls -la";
      ".." = "cd ..";
      "..." = "cd ../..";

      # Nix aliases
      rebuild = "darwin-rebuild switch --flake ~/.config/nix";

      # Git aliases
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline";
    };

    # History configuration
    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
    };

    # Oh My Zsh configuration (optional)
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" "kubectl" ];
      theme = "robbyrussell";
    };
  };
}

