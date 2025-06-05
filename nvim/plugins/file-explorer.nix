{ ... }: {
  config.plugins = {
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
  };

  config.extraConfigLua = ''
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
