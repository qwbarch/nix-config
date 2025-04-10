{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      username = "qwbarch";
      hostName = "edward-nixos";
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = import ./system/configuration.nix {
        inherit pkgs system hostName; 
        lib = nixpkgs.lib;
      };
    };
}
