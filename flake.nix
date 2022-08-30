{
  description = "NixOS flake configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    home-manager = {
      url = github:nix-community/home-manager/release-22.05;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      username = "qwbarch";
      hostName = "edward-nixos";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
	config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        ${hostName} = lib.nixosSystem {
          inherit system;
	  modules = [
            ./configuration.nix
	  ];
	};
      };
      homeManagerConfiguration = {
        ${username} = home-manager.lib.homeManagerConfiguration {
	  inherit system pkgs username;
	  homeDirectory = "/home/${username}";
	  stateVersion = "22.05";
	  configuration = {
            imports = [
              ./home.nix
	    ];
	  };
	};
      };
    };
}
