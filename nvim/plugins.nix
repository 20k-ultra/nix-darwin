{ pkgs, ... }: {
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
          specialFiles = [ "README.md" "Makefile" "MAKEFILE" "go.mod" "cargo.toml" ];
        };
        onAttach = "default";
        updateFocusedFile = {
          enable = true;
          updateRoot = false;
          ignoreList = [ ];
        };
      };

      # Other UI plugins
      bufferline = {
        enable = true;
        settings = {
          options = {
            show_buffer_icons = false; # Remove file type icons
            show_buffer_close_icons = false; # Remove the "x" on each buffer
            show_close_icon = false; # Remove the close button at the end
            buffer_close_icon = ""; # Make buffer close icon empty (backup)
            close_icon = ""; # Make close icon empty (backup)
            modified_icon = "●"; # Show dot indicator for modified buffers
            indicator = {
              style = "none"; # Remove the line indicator on active buffer
            };
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
       -- Smart buffer close function that prevents focus moving to nvim-tree
       -- and closes editor when no buffers remain
       local function smart_close_buffer()
         local current_buf = vim.api.nvim_get_current_buf()
         local current_win = vim.api.nvim_get_current_win()
        
         -- Get all valid, listed buffers except the current one
         local buffers = vim.tbl_filter(function(buf)
           return vim.api.nvim_buf_is_valid(buf) 
             and vim.bo[buf].buflisted 
             and buf ~= current_buf
         end, vim.api.nvim_list_bufs())
        
         -- If no other buffers exist, close the editor
         if #buffers == 0 then
           vim.cmd("qall")
           return
         end
        
         -- If we're in nvim-tree or there are other buffers available
         if vim.bo.filetype == "NvimTree" or #buffers > 0 then
           -- Find a non-nvim-tree window to focus
           local windows = vim.api.nvim_list_wins()
           for _, win in ipairs(windows) do
             local win_buf = vim.api.nvim_win_get_buf(win)
             local ft = vim.bo[win_buf].filetype
             if ft ~= "NvimTree" and ft ~= "help" and ft ~= "qf" and ft ~= "quickfix" then
               vim.api.nvim_set_current_win(win)
               if #buffers > 0 then
                 vim.cmd("buffer " .. buffers[1])
               end
               break
             end
           end
         end
        
         -- Close the buffer
         vim.cmd("bdelete " .. current_buf)
       end

       -- Make the function globally available
       _G.smart_close_buffer = smart_close_buffer

      -- enforce a quit all behaviour so calling quit once closes editor
      vim.cmd([[
        cnoreabbrev wq write<bar>qall
        cnoreabbrev Wq write<bar>qall  
        cnoreabbrev WQ write<bar>qall
      ]])

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

      -- Bufferline color customization for a more subtle active buffer
       vim.api.nvim_create_autocmd("ColorScheme", {
         callback = function()
           -- Set more subtle bufferline colors
           vim.api.nvim_set_hl(0, "BufferLineTabSelected", {
             bg = "#2D2E32", -- Slightly darker than background
             fg = "#F8F8F2", -- Normal foreground
             bold = true
           })
          
           vim.api.nvim_set_hl(0, "BufferLineBackground", {
             bg = "#1B1D1E", -- Match your terminal background
             fg = "#6C6C6C" -- Dimmer text for inactive buffers
           })
          
           vim.api.nvim_set_hl(0, "BufferLineModified", {
             bg = "#1B1D1E",
             fg = "#FF6E67" -- Subtle red for modified indicator
           })
          
           vim.api.nvim_set_hl(0, "BufferLineModifiedSelected", {
             bg = "#2D2E32",
             fg = "#FF6E67" -- Red for active modified buffer
           })
          
           -- Remove separator styling for cleaner look
           vim.api.nvim_set_hl(0, "BufferLineSeparator", {
             bg = "#1B1D1E",
             fg = "#1B1D1E"
           })
         end
       })

       -- Apply colors immediately after colorscheme loads
       vim.defer_fn(function()
         vim.cmd("doautocmd ColorScheme")
       end, 100)
    '';

    # Extra packages to install
    extraPackages = with pkgs; [
      ripgrep
      fd
    ];
  };
}

