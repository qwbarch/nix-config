{ pkgs, system, home-manager, username, stateVersion, ... }:

let
  stablePackages = with pkgs; [
    # Applications
    vscode
    discord
    peek

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
    unzip

    # Programming
    nix-prefetch-git
    nodejs
    yarn
    rnix-lsp
    postman
    purescript
    spago
    nodePackages.purty
    nodePackages.purescript-language-server
    nodePackages.prettier
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
