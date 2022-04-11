{ config, pkgs, ... }:

{
  home.username = "qwbarch";
  home.homeDirectory = "/home/qwbarch";

  home.stateVersion = "21.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # Resource management
    htop
    nvtop

    # Terminal
    alacritty

    # Utility
    google-chrome
  ];

  home.file = {
    ".config/alacritty/alacritty.yaml".text = ''
      env:
        TERM: xterm-256color
    '';
  };
}
