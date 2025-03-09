{ pkgs, ... }: {
  plugins = {
    # Add Rust to treesitter
    treesitter.settings.ensure_installed = [ "rust" ];

    # Configure rustaceanvim
    rustaceanvim = {
      enable = true;
      # Use the rust-analyzer package from nixpkgs
      rustAnalyzerPackage = pkgs.rust-analyzer;
      # Configure rustaceanvim settings
      settings = {
        server = {
          default_settings = {
            "rust-analyzer" = {
              # Use clippy for checking
              check = {
                command = "clippy";
              };
              procMacro = {
                enable = true;
              };
              cargo = {
                buildScripts = {
                  enable = true;
                };
              };
            };
          };
        };
        # DAP configuration
        dap = {
          adapter = {
            type = "executable";
            command = "${pkgs.lldb}/bin/lldb-vscode";
            name = "lldb";
          };
        };
      };
    };

    # Add nvim-dap support for Rust
    dap = {
      enable = true;
    };

    # Enable dap-virtual-text as separate plugin
    dap-virtual-text.enable = true;

    # Enable Crates plugin for Cargo.toml management
    crates.enable = true;
  };

  # Additional configuration for Rust
  extraConfigLua = ''
    -- Rust specific settings
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "rust",
      callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.expandtab = true
      end
    })
  '';

  # Install necessary Rust tools
  extraPackages = with pkgs; [
    # Rust and cargo
    rustc
    cargo
    
    # Language server and linters
    rust-analyzer
    clippy
    rustfmt
    
    # Debug adapter
    lldb
    
    # Additional Rust tools
    cargo-edit     # Cargo subcommands to add/remove/upgrade dependencies
    cargo-watch    # Watch for changes and run cargo commands
    cargo-audit    # Security audit for Cargo.lock
    cargo-expand   # Shows result of macro expansion
  ];
}
