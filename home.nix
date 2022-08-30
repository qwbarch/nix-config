{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    google-chrome
    neovim
    bitwarden
  ];
}
