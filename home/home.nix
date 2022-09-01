{ config, system, pkgs, ... }:

let
  username = "qwbarch";
in
{
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    # Applications
    google-chrome
    bitwarden
    vscode
    neovim
    spotify

    # Desktop
    htop-vim
    feh
    playerctl

    # Utility
    nix-prefetch-git
  ];
  home = {
    inherit username;

    homeDirectory = "/home/${username}";
    stateVersion = "22.05";
  };

  # Restart services on change
  systemd.user.startServices = "sd-switch";

  imports = (import ./programs) ++ (import ./services);
}
