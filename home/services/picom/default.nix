{ pkgs, ... }:

let
  opaqueWindows = [ "Rofi" "firefox" "steam" ];
in
{
  services.picom = {
    enable = true;
    package = pkgs.picom.overrideAttrs (_: {
      src = pkgs.fetchFromGitHub {
        repo = "picom";
        owner = "ibhagwan";
        rev = "44b4970f70d6b23759a61a2b94d9bfb4351b41b1";
        sha256 = "0iff4bwpc00xbjad0m000midslgx12aihs33mdvfckr75r114ylh";
      };
    });

    activeOpacity = "1.0";
    inactiveOpacity = "0.8";
    fade = true;

    opacityRule = map (window: "100:class_g *?= '${window}'") opaqueWindows;

    extraOptions = ''
      corner-radius = 8;
      rounded-corners-exclude = [
        "class_i = 'polybar'"
      ];
    '';
  };
}
