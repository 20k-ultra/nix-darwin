{pkgs, ...}: {
  # Use explicit config attribute for all configuration
  config = {
    # Main colorscheme
    colorschemes.tokyonight = {
      enable = true;
      settings.style = "storm";  # Fixed: changed style to settings.style
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
      comment.enable = true;  # Fixed: changed from comment-nvim.enable to comment.enable
      treesitter = {
        enable = true;
        settings.ensure_installed = [ "lua" "nix" "bash" "markdown" "json" ];
        folding = true;
      };
      
      # Enhanced completion configuration
      cmp = {
        enable = true;
        settings = {
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
          };
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
            { name = "treesitter"; }
          ];
          snippet.expand = ''
            function(args)
              require('luasnip').lsp_expand(args.body)
            end
          '';
        };
      };
      
      # Additional completion plugins
      lspkind.enable = true;  # For nice icons in completion menu
      luasnip.enable = true;  # For snippets in completion
      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          bashls.enable = true;
        };
      };
    };
    
    # More comprehensive configuration for icons and completion
    extraConfigLua = ''
      -- Ensure UTF-8 encoding
      vim.opt.encoding = "UTF-8"
      
      -- Explicitly set that we have a nerd font
      vim.g.have_nerd_font = true
      
      -- Basic web-devicons setup
      require('nvim-web-devicons').setup {
        default = true
      }
      
      -- Set completion options
      vim.opt.completeopt = {"menu", "menuone", "noselect"}
      
      -- Configure automatic completion
      vim.opt.updatetime = 300

      -- Configure folding
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldlevelstart = 99  -- Start with all folds open
      
      -- Ensure folding works with LSP
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.server_capabilities.foldingRangeProvider then
            vim.opt_local.foldmethod = "expr"
            vim.opt_local.foldexpr = "vim.lsp.buf.folding_range()"
          end
        end
      })
    '';
    
    # Extra packages to install with Neovim
    extraPackages = with pkgs; [
      ripgrep
      fd
    ];
  };
}
