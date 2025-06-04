{pkgs, ...}: {
  config = {
    colorscheme = "sonokai";
    
    extraPlugins = [
      (pkgs.vimUtils.buildVimPlugin {
        name = "sonokai";
        src = pkgs.fetchFromGitHub {
          owner = "20k-ultra";
          repo = "sonokai";
          rev = "master";
          sha256 = "sha256-qROaZx0kIYVT8yCrTmK0cVDw9LPVCS1J1GslUc2ZrP0=";
        };
      })
    ];

    plugins = {
      # Web devicons for file icons
      web-devicons.enable = true;
      
      # File explorer configuration
      nvim-tree = {
        enable = true;
        filters.dotfiles = false;
        view = {
          width = 30;
          side = "left";
        };
        git.enable = true;
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
          indentWidth = 2;
          specialFiles = ["README.md" "Makefile" "MAKEFILE" "go.mod" "cargo.toml"];
        };
        onAttach = "default";
        updateFocusedFile = {
          enable = true;
          updateRoot = false;
          ignoreList = [];
        };
      };
      
      # Other UI plugins
      bufferline = {
        enable = true;
        settings = {
          options = {
            show_buffer_icons = false;      # Remove file type icons
            show_buffer_close_icons = false; # Remove the "x" on each buffer
            show_close_icon = false;        # Remove the close button at the end
            buffer_close_icon = "";         # Make buffer close icon empty (backup)
            close_icon = "";                # Make close icon empty (backup)
            modified_icon = "";             # Remove the modified indicator
          };
        };
      };
      telescope.enable = true;
      lualine.enable = true;
      gitsigns.enable = true;
      nvim-autopairs.enable = true;
      comment.enable = true;
      
      # Treesitter configuration
      treesitter = {
        enable = true;
        settings = {
          ensure_installed = [ "lua" "nix" "bash" "markdown" "json" ];
          highlight = {
            enable = true;
            additional_vim_regex_highlighting = false;
          };
        };
        folding = true;
      };
      
      # Completion configuration
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
      
      # LSP support plugins
      lspkind.enable = true;
      luasnip.enable = true;
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
    
    # Improved Lua configuration
    extraConfigLua = ''
      -- UTF-8 encoding
      vim.opt.encoding = "UTF-8"
      
      -- Nerd font setting
      vim.g.have_nerd_font = true
      
      -- Sonokai theme configuration
      vim.g.sonokai_style = 'default'  -- Options: default, atlantis, andromeda, shusia, maia, espresso
      vim.g.sonokai_better_performance = 1
      vim.g.sonokai_enable_italic = 1
      vim.g.sonokai_disable_italic_comment = 0
      vim.g.sonokai_transparent_background = 0
      vim.g.sonokai_current_word = 'bold'  -- Make current word stand out
      vim.g.sonokai_diagnostic_line_highlight = 1
      vim.g.sonokai_diagnostic_virtual_text = 'colored'
      
      -- Web devicons setup
      require('nvim-web-devicons').setup {
        default = true
      }
      
      -- Set completion options
      vim.opt.completeopt = {"menu", "menuone", "noselect"}
      
      -- Configure automatic completion
      vim.opt.updatetime = 250
      
      -- Better syntax highlighting with treesitter
      require('nvim-treesitter.configs').setup {
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }

      -- Folding configuration
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldlevelstart = 99  -- Start with all folds open
      
      -- Fix folding issues with LSP
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*",
        callback = function()
          if vim.bo.filetype == "go" then
            -- Ensure folding is properly set for Go files
            vim.opt_local.foldmethod = "expr" 
            vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
          end
        end
      })
      
      -- Force treesitter to use semantic tokens from LSP
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.server_capabilities.semanticTokensProvider then
            vim.lsp.semantic_tokens.start(vim.api.nvim_get_current_buf(), client.id)
          end
        end
      })
      
      -- Auto open NvimTree with directories
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          if vim.fn.isdirectory(vim.fn.argv(0)) ~= 0 then
            require("nvim-tree.api").tree.open()
          end
        end
      })
    '';
    
    # Extra packages to install
    extraPackages = with pkgs; [
      ripgrep
      fd
    ];
  };
}
