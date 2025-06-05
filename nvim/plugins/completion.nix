{ ... }: {
  plugins = {
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

    # Completion support plugins
    lspkind.enable = true;
    luasnip.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp-buffer.enable = true;
    cmp-path.enable = true;
  };

  extraConfigLua = ''
    -- Set completion options
    vim.opt.completeopt = {"menu", "menuone", "noselect"}

    -- Configure automatic completion
    vim.opt.updatetime = 250
  '';
}

