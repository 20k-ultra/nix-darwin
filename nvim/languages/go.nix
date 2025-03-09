{ pkgs, ... }: {
  plugins = {
    # Add Go to treesitter
    treesitter.settings.ensure_installed = [ "go" ];

    # Configure LSP for Go
    lsp.servers.gopls = {
      enable = true;
      settings = {
        gofumpt = true;  # Use gofumpt for formatting
      };
    };

    # Add nvim-dap support for Go
    dap.enable = true;
    dap-go.enable = true;  # Fixed: moved from dap.extensions.dap-go to top-level
  };

  # Add gopher.nvim as a custom plugin
  extraPlugins = with pkgs.vimPlugins; [
    # Try different possible names
    (pkgs.vimPlugins.gopher-nvim or pkgs.vimPlugins.gopher_nvim or null)
  ];

  # Configuration for gopher.nvim
  extraConfigLua = ''
    -- Check if gopher is available before setting it up
    local ok, gopher = pcall(require, "gopher")
    if ok then
      gopher.setup()
    end
  '';

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
