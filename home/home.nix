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
    xmousepasteblock

    # Programming
    nix-prefetch-git
    nodejs
    rnix-lsp
    ormolu
  ];

  # Restart services on change
  systemd.user.startServices = "sd-switch";

  imports = (import ./programs) ++ (import ./services);
}
