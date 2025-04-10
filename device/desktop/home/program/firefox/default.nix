{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    #profiles.profile.extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
    #  ublock-origin
    #];
  };
}
