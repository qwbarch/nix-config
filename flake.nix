{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nurpkgs = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, unstable, home-manager, nurpkgs, ... }:
    let
      username = "qwbarch";
      hostName = "edward-nixos";
      system = "x86_64-linux";
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [ "libav-11.12" ];
      };
      localOverlay = prev: final: {
        polybar-spotify = final.callPackage ./home/overlays/polybar-spotify.nix { };
        arcanists2 = final.callPackage ./home/overlays/arcanists2.nix { };
        awakened-poe-trade = final.callPackage ./home/overlays/awakened-poe-trade.nix { };
        unstable = import unstable {
          inherit config;
          system = final.system;
        };
      };
      pkgs = import nixpkgs {
        inherit system config;
        overlays = [ localOverlay nurpkgs.overlay ];
      };
      nur = import nurpkgs {
        inherit pkgs;
        nurpkgs = pkgs;
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
        inherit pkgs system username hostName stateVersion;
        lib = nixpkgs.lib;
      };
      homeManagerConfiguration = import ./home/home.nix {
        inherit pkgs home-manager system username stateVersion;
      };
    };
}
