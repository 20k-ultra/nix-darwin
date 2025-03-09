{ pkgs, ... }: {
  plugins = {
    # Add Go to treesitter
    treesitter = {
      enable = true;
      settings = {
        ensure_installed = [ "go" ];
        highlight = {
          enable = true;
          additional_vim_regex_highlighting = false;
        };
      };
    };

    # Configure LSP for Go
    lsp.servers.gopls = {
      enable = true;
      settings = {
        gofumpt = true;
        analyses = {
          unusedparams = true;
          shadow = true;
        };
        staticcheck = true;
        usePlaceholders = true;
        completeUnimported = true;
        semanticTokens = true;  # Important for better syntax highlighting
      };
    };

    # Add nvim-dap support for Go
    dap.enable = true;
    dap-go.enable = true;
  };

  # Install necessary Go tools
  extraPackages = with pkgs; [
    # Go itself
    go

    # Go tools
    gopls
    golangci-lint
    
    # Additional Go tools
    gotools
    gomodifytags
    gotests
    iferr
    impl
    delve  # Debugger
  ];
}
