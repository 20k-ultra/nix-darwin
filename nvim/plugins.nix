{pkgs, ...}: {
  # Use explicit config attribute for all configuration
  config = {
    # Main colorscheme
    colorschemes.tokyonight = {
      enable = true;
      style = "storm";
    };

    plugins = {
      # Web devicons for file icons - more explicit configuration
      web-devicons = {
        enable = true;
        # default = true;
      };

      # File explorer with explicit icon settings
      nvim-tree = {
        enable = true;
        filters.dotfiles = false;
        view = {
          width = 30;
          side = "left";
        };
        git = {
          enable = true;
        };
        renderer = {
          highlightGit = true;
          indentMarkers.enable = true;
          icons = {
            show = {
              file = true;
              folder = true;
              git = true;
            };
          };
        };
        # Use default key mappings
        onAttach = "default";
      };

      # Other plugins remain the same
      bufferline.enable = true;
      telescope.enable = true;
      #lualine = {
      #  enable = true;
      #  icons_enabled = true;  # Explicitly enable icons
      #};
      gitsigns.enable = true;
      nvim-autopairs.enable = true;
      comment-nvim.enable = true;
      treesitter = {
        enable = true;
        ensureInstalled = [ "lua" "nix" "bash" "markdown" "json" ];
      };
      cmp.enable = true;
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          bashls.enable = true;
        };
      };
    };

    # More comprehensive configuration for icons
    extraConfigLua = ''
      -- Ensure UTF-8 encoding
      vim.opt.encoding = "UTF-8"
      
      -- Explicitly set that we have a nerd font
      vim.g.have_nerd_font = true
      
      -- Basic web-devicons setup
      require('nvim-web-devicons').setup {
        default = true
      }
    '';

    # Extra packages to install with Neovim
    extraPackages = with pkgs; [
      ripgrep
      fd
    ];
  };
}
