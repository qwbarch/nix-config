{ pkgs, system, home-manager, username, stateVersion, ... }:

let
  stablePackages = with pkgs; [
    # Applications
    vscode
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
    jq

    # Programming
    git-lfs
    nix-prefetch-git
    nodejs
    rnix-lsp
    postman
  ];
  unstablePackages = with pkgs.unstable; [
    # Applications
    signal-desktop
    spotify
    ledger-live-desktop
    bitwarden
  ];
in {
  ${username} = home-manager.lib.homeManagerConfiguration {
    inherit pkgs system username stateVersion;
    homeDirectory = "/home/${username}";
    configuration = {
      programs.home-manager.enable = true;
      services.blueman-applet.enable = true;

      home.packages = stablePackages ++ unstablePackages;

      # Restart services on change
      systemd.user.startServices = "sd-switch";

      imports = (import ./programs) ++ (import ./services);
    };
  };
}
