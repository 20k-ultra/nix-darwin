{ pkgs, ... }: {
  plugins = {
    # Add Nix to treesitter
    treesitter.ensureInstalled = [ "nix" ];

    # Configure LSP for Nix
    lsp.servers.nil_ls = {
      enable = true;
      settings = {
        formatting = {
          command = [ "nixpkgs-fmt" ];
        };
      };
    };
  };

  # Configuration for Nix
  extraConfigLua = ''
    -- Additional Nix configuration if needed
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "nix",
      callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.expandtab = true
      end
    })
  '';

  # Install necessary Nix tools
  extraPackages = with pkgs; [
    # Nix language server
    nil  # Nix language server

    # Nix formatting and linting tools
    nixpkgs-fmt  # Formatter
    statix  # Linter for Nix code
    
    # Additional Nix tools
    nixd  # Alternative Nix language server (optional)
  ];
}
