{
  description = "Darwin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs@{ nixpkgs, home-manager, darwin, nur, ... }:
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
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.mig = import ./home.nix;
          nixpkgs.overlays = [
            inputs.nur.overlays.default
            (final: prev: {
              firefox-dev = prev.callPackage ./firefox/firefox-darwin.nix {};
            })
          ];
        }
      ];
    };
  };
}
