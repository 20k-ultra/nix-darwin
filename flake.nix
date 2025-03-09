{
  description = "Darwin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    
    # NixVim inputs
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    
    # For parts-based flake structure
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ nixpkgs, home-manager, darwin, nur, nixvim, flake-parts, ... }:
  let
    system = "aarch64-darwin";
    
    # Create custom neovim package
    nvim-pkg = nixvim.legacyPackages.${system}.makeNixvimWithModule {
      pkgs = nixpkgs.legacyPackages.${system};
      module = import ./nvim;
      # Add any extra arguments your modules might need
      extraSpecialArgs = { };
    };
  in
  {
    darwinConfigurations."ghost-m3" = darwin.lib.darwinSystem {
      inherit system;
      modules = [
        ./darwin.nix
        home-manager.darwinModules.home-manager
        {
          nixpkgs.config.allowUnfree = true;
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.mig = { pkgs, ... }: {
            # Import your existing home-manager configuration
            imports = [ 
              ./firefox 
              ./nodejs
              ./zsh
              ./alacritty
            ];
            
            # Your other home-manager configurations
            programs.git = {
              enable = true;
              userName = "20k-ultra";
              userEmail = "3946250+20k-ultra@users.noreply.github.com";
              extraConfig = {
                gpg.format = "ssh";
                commit.gpgsign = false;
                user.signingkey = "~/.ssh/id_ed25519";
              };
            };

            home.packages = with pkgs; [
              git
              google-cloud-sdk
              gnumake
              tree
              discord
              gnupg
              jq
              btop
              nvim-pkg
            ];

            home.stateVersion = "23.05";
          };
          nixpkgs.overlays = [
            inputs.nur.overlays.default
            (final: prev: {
              firefox-dev = prev.callPackage ./firefox/firefox-darwin.nix {};
            })
          ];
        }
      ];
      specialArgs = { inherit inputs; };
    };
    
    # Add a devShell to easily test your Neovim configuration
    devShells.${system}.default = nixpkgs.legacyPackages.${system}.mkShell {
      packages = [ nvim-pkg ];
    };
  };
}
