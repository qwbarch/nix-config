{ pkgs, ... }:

{
  services.polybar = {
    enable = true;
    config = ./config.ini;
    package = pkgs.polybar.override {
      i3Support = true;
      alsaSupport = true;
      pulseSupport = true;
    };
    script = "polybar &";
    extraConfig = (builtins.readFile ./modules.ini) + ''
      [module/spotify]
      type = custom/script
      interval = 1.0
      tail = true
      format-prefix = " "
      format = <label>
      exec = ${pkgs.polybar-spotify}
    '';
  };
}
