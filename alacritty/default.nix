{ config, pkgs, ... }:
{
  home.sessionVariables = {
    TERMINAL = "alacritty";
  };
  
  home.packages = with pkgs; [
    alacritty
  ];
  
  programs.alacritty = {
    enable = true;
    
    settings = {
      font = {
        size = 22.0;
      };
      
      window = {
        opacity = 0.95;
        padding = {
          x = 0;
          y = 0;
        };
      };
      
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
      
      terminal = {
        shell = {
          program = "${pkgs.zsh}/bin/zsh";
        };
      };
      
    };
  };
}
