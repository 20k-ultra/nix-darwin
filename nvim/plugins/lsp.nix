{ ... }: {
  plugins = {
    lsp = {
      enable = true;
      servers = {
        nil_ls.enable = true;
        bashls.enable = true;
      };
    };
  };

  extraConfigLua = ''
    -- Force treesitter to use semantic tokens from LSP
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.semanticTokensProvider then
          vim.lsp.semantic_tokens.start(vim.api.nvim_get_current_buf(), client.id)
        end
      end
    })
  '';
}

