# zsh/default.nix
{ config, pkgs, ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.file.".curl-format".text = ''
     time_namelookup:  %{time_namelookup}s\n
        time_connect:  %{time_connect}s\n
     time_appconnect:  %{time_appconnect}s\n
    time_pretransfer:  %{time_pretransfer}s\n
       time_redirect:  %{time_redirect}s\n
  time_starttransfer:  %{time_starttransfer}s\n
                     ----------\n
          time_total:  %{time_total}s\n
  '';

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "alanpeabody";
    };

    plugins = [
      # Vi keybindings
      {
        name = "zsh-vi-mode";
        file = "./share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        src = pkgs.zsh-vi-mode;
      }
    ];

    shellAliases = rec {
      dotfiles = "cd ~/.config/nix";
      railway-local = "RAILWAY_ENV=dev ~/Projects/cli/target/release/railway";
      ls = "ls --color=auto";
      gpm = "git pull origin main";
      gpom = "git pull origin main";
      gs = "git status";
      gcm = "git checkout main";
      gf = "git fetch";
      gca = "git commit --amend";
      gpf = "git push -f";
    };

    initExtra = ''
      # Set EDITOR and VISUAL environment variables
      export EDITOR="nvim"
      export VISUAL="nvim"
      
      # Enable case-insensitive completion
      zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

      eval "$(direnv hook zsh)"

      # Set the curl format file path
      export CURL_TIMED_FORMAT="$HOME/.curl-format"

      # Add the timed_curl function
      timed_curl() {
          curl -w "@$CURL_TIMED_FORMAT" -o /dev/null -s "$1"
      }

      note() {
          # Set the EDITOR environment variable to your preferred text editor
          EDITOR=''${EDITOR:-vi}

          # Set the NOTES_DIR environment variable to the directory where notes should be saved
          NOTES_DIR=''${NOTES_DIR:-~/notes}

          # Set the file type for notes (so that the editor LSP can work)
          NOTES_TYPE=''${NOTES_TYPE:-.md}

          # Check if the NOTES_DIR folder exists
          if [ ! -d "$NOTES_DIR" ]
          then
              # If the folder does not exist, create it
              mkdir "$NOTES_DIR"
          fi

          if [ -z "$1" ]; then
              # If no filename is provided, create a new file with a timestamp in the name
              filename="note-$(date +'%Y-%m-%d_%H-%M-%S')$NOTES_TYPE"
          else
              # Use the provided filename
              filename="$1"
          fi

          # Open the file in the text editor
          $EDITOR "$NOTES_DIR/$filename"
      }

      # notes function
      notes() {
          # Set the NOTES_DIR environment variable to the directory where notes should be saved
          NOTES_DIR=''${NOTES_DIR:-~/notes}

          # Set the internal field separator to a newline character
          # so that we can loop through the output of 'ls' line by line
          IFS=$'\n'

          # Print the table header
          printf "+-------------------------------------+----------------+\n"
          printf "|                 Note                |      Date      |\n"
          printf "+-------------------------------------+----------------+\n"

          # Loop through the output of 'ls'
          ls -tl "$NOTES_DIR" | tail -n +2 | while read -r line; do
              # Extract the file name and date from the line
              file=$(echo "$line" | awk '{print $9}')
              date=$(echo "$line" | awk '{print $6, $7, $8}')

              # Print the file name and date in a table row
              printf "| %-35s | %-15s|\n" "$file" "$date"
          done

          # Print the table footer
          printf "+-------------------------------------+----------------+\n"
      }
    '';
  };
}
