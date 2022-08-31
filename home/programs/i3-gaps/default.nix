{ pkgs, lib, ... }:

{
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };
  home.file.".i3/config".source = ./config;
}
