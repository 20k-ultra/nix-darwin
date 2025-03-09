{ pkgs, ... }: {
  plugins = {
    # Add Go to treesitter
    treesitter.ensureInstalled = [ "go" ];

    # Configure LSP for Go
    lsp.servers.gopls = {
      enable = true;
      settings = {
        gofumpt = true;  # Use gofumpt for formatting
      };
    };

    # Add nvim-dap support for Go
    dap = {
      enable = true;
      extensions = {
        dap-go.enable = true;
      };
    };

    # Add gopher.nvim for Go-specific tools
    #gopher-nvim = {
    #  enable = true;
    #};
  };

  # Install necessary Go tools
  extraPackages = with pkgs; [
    # Go itself
    go

    # Go tools
    gopls  # Language server
    golangci-lint  # Linter
    
    # Additional Go tools
    gotools  # Contains goimports
    gomodifytags
    gotests
    iferr
    impl
  ];
}
