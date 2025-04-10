{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager"; 
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

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      stateVersion = "22.05"; # Did you read the comment?
    in
    {
      nixosConfigurations = import ./system/configuration.nix {
        inherit pkgs system hostName stateVersion; 
        lib = nixpkgs.lib;
      };
      homeManagerConfiguration = import ./home/home.nix {
        inherit pkgs home-manager system username stateVersion;
      };
    };
}
