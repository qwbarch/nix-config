{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userEmail = "qwbarch@gmail.com";
    userName = "qwbarch";
    extraConfig = {
      lfs.enable = true;
      pull.rebase = true;
      push.autoSetupRemote = true;
    };
  };
}
