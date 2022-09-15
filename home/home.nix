{ pkgs, unstable, system, home-manager, username, stateVersion, ... }:

let
  stablePackages = with pkgs; [
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
    nix-prefetch-git
    nodejs
    rnix-lsp
  ];
  unstablePackages = with unstable; [
    # Applications
    vscode
    spotify
    signal-desktop
    discord
    discord
    ledger-live-desktop
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
