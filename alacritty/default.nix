{ config, pkgs, ... }:
{
  home.sessionVariables = {
    TERMINAL = "alacritty";
  };
  
  # Install Alacritty package
  home.packages = with pkgs; [
    alacritty
  ];
  
  # Configure Alacritty with settings similar to WezTerm
  programs.alacritty = {
    enable = true;
    
    settings = {
      # Font configuration
      font = {
        size = 40.0;
        normal.family = "monospace";
      };
      
      # Disable ligatures (equivalent to harfbuzz_features disabling ligatures)
      font_features = {
        "*" = {
          calt = false;
          clig = false;
          liga = false;
        };
      };
      
      # Window settings
      window = {
        opacity = 0.9;
        padding = {
          x = 0;
          y = 0;
        };
      };
      
      # Custom colors similar to your Sonokai theme
      colors = {
        primary = {
          background = "#1B1D1E";
          foreground = "#F8F8F2";
        };
        normal = {
          black = "#1B1D1E";
          red = "#FF5555";
          green = "#50FA7B";
          yellow = "#F1FA8C";
          blue = "#BD93F9";
          magenta = "#FF79C6";
          cyan = "#8BE9FD";
          white = "#BFBFBF";
        };
        bright = {
          black = "#4D4D4D";
          red = "#FF6E67";
          green = "#5AF78E";
          yellow = "#F4F99D";
          blue = "#CAA9FA";
          magenta = "#FF92D0";
          cyan = "#9AEDFE";
          white = "#E6E6E6";
        };
        cursor = {
          text = "#1B1D1E";
          cursor = "#F8F8F2";
        };
        selection = {
          text = "#F8F8F2";
          background = "#44475A";
        };
      };
      
      # Shell integration
      shell = {
        program = "${pkgs.zsh}/bin/zsh";
      };
      
      # Hide decorations (tabs equivalent)
      window.decorations = "none";
    };
  };
}
