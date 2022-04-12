{
  description = "A flake defining my NixOS dependencies, backed by git.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-21.11";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };
    lib = nixpkgs.lib;
  in {
    homeManagerConfigurations = {
      qwbarch = home-manager.lib.homeManagerConfiguration {
        inherit system pkgs; 
        username = "qwbarch";
        stateVersion = pkgs.lib.trivial.release;
        homeDirectory = "/home/qwbarch";
        configuration = {
          imports = [
            ./users/qwbarch/home.nix
          ];
        };
      };
    };
    nixosConfigurations = {
      edward-nixos = lib.nixosSystem {
        inherit system;
        modules = [
          ./system/configuration.nix
        ];
      };
    };
  };
}
