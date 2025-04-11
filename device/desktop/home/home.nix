{ pkgs, home-manager, system, username, stateVersion, ...}:

let
  packages = with pkgs; [
    # Applications
    bitwarden
    spotify
    htop-vim

    # Programming
    vscode

  ];
in
{
  nixpkgs = {
    overlays = [];
    config = {
      allowUnfree = true;
      # https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    inherit username stateVersion packages;
    homeDirectory = "/home/${username}";
  };

  programs.home-manager.enable = true;
  systemd.user.startServices = "sd-switch";

  imports = (import ./program) ++ (import ./service);
}
