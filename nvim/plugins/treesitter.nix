{ ... }: {
  config.plugins = {
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
  };

  config.extraConfigLua = ''
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
  '';
}
