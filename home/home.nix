{ config, system, pkgs, nur, ... }:

{
  programs.home-manager.enable = true;
  services.blueman-applet.enable = true;

  home.packages = with pkgs; [
    # Applications
    bitwarden
    vscode
    spotify
    discord

    # Desktop
    htop-vim
    nvtop
    feh
    playerctl
    xbanish
    neofetch
    xclip
    ripgrep

    # Programming
    nix-prefetch-git
    nodejs
    rnix-lsp
  ];

  # Restart services on change
  systemd.user.startServices = "sd-switch";

  imports = (import ./programs) ++ (import ./services);
}
