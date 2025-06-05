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
    in
    {
      darwinConfigurations."ghost-m3" = darwin.lib.darwinSystem {
        inherit system;
        modules = [
          ./darwin.nix
          home-manager.darwinModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            nixpkgs.config.allowBroken = true;
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.sharedModules = [ inputs.nixvim.homeManagerModules.nixvim ];

            # Simply import the home.nix file instead of duplicating everything
            home-manager.users.mig = import ./home.nix;

            nixpkgs.overlays = [
              inputs.nur.overlays.default
            ];
          }
        ];
        specialArgs = { inherit inputs; };
      };
    };
}
