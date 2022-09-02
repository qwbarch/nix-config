{ config, system, pkgs, ... }:

let
  username = "qwbarch";
in
{
  programs.home-manager.enable = true;
  services.blueman-applet.enable = true;

  home.packages = with pkgs; [
    # Applications
    bitwarden
    vscode
    neovim
    spotify
    discord
    firefox

    # Desktop
    htop-vim
    feh
    playerctl
    xbanish
    neofetch

    # Programming
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
