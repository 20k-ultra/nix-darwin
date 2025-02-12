{ config, pkgs, ... }:

{
  home.sessionVariables = {
    TERMINAL = "wezterm";
  };

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    
    extraConfig = ''
      local wezterm = require("wezterm")
      local config = {}

      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      -- Theme + Font
      config.color_scheme = "Sonokai (Gogh)"
      config.font_size = 20.0
      config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
      
      -- Background
      config.window_background_opacity = 0.9
      config.text_background_opacity = 0.4
      
      -- Hide tabs
      config.hide_tab_bar_if_only_one_tab = true
      
      -- Padding
      config.window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
      }

      return config
    '';

    colorSchemes = {
      custom = {
        ansi = [
          "#1B1D1E" # black
          "#FF5555" # red
          "#50FA7B" # green
          "#F1FA8C" # yellow
          "#BD93F9" # blue
          "#FF79C6" # magenta
          "#8BE9FD" # cyan
          "#BFBFBF" # white
        ];
        brights = [
          "#4D4D4D" # bright black
          "#FF6E67" # bright red
          "#5AF78E" # bright green
          "#F4F99D" # bright yellow
          "#CAA9FA" # bright blue
          "#FF92D0" # bright magenta
          "#9AEDFE" # bright cyan
          "#E6E6E6" # bright white
        ];
        background = "#1B1D1E";
        foreground = "#F8F8F2";
        cursor_bg = "#F8F8F2";
        cursor_fg = "#1B1D1E";
        selection_bg = "#44475A";
        selection_fg = "#F8F8F2";
      };
    };
  };
}
