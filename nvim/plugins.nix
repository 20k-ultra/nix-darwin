{ pkgs, ... }: {
  imports = [
    ./plugins/theme.nix
    ./plugins/file-explorer.nix
    ./plugins/ui.nix
    ./plugins/treesitter.nix
    ./plugins/completion.nix
    ./plugins/lsp.nix
    ./plugins/core-config.nix
  ];

  # Extra packages needed by various plugins
  extraPackages = with pkgs; [
    ripgrep
    fd
  ];
}
