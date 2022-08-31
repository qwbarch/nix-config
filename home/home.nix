{ config, pkgs, ... }:

let
  username = "qwbarch";
in
{
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    # Applications
    google-chrome
    bitwarden

    # Window manager
    neovim
    alacritty
    htop-vim
    dmenu
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
