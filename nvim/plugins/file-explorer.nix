{ ... }: {
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

      # Enable diagnostics to show only LSP errors
      diagnostics = {
        enable = true;
        showOnDirs = true;
        showOnOpenDirs = true;
        debounceDelay = 50;
        severity = {
          min = "error";
          max = "error";
        };
        icons = {
          error = "●";
        };
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
  };

  extraConfigLua = ''
    -- Define diagnostic error sign for nvim-tree BEFORE loading nvim-tree
    vim.fn.sign_define("NvimTreeDiagnosticErrorIcon", {
      text = "●",
      texthl = "DiagnosticError",
      numhl = "DiagnosticError"
    })

    -- Web devicons setup
    require('nvim-web-devicons').setup {
      default = true
    }

    -- Auto open NvimTree with directories
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        if vim.fn.isdirectory(vim.fn.argv(0)) ~= 0 then
          require("nvim-tree.api").tree.open()
        end
      end
    })
  '';
}
