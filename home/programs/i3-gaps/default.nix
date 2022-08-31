{ pkgs, lib, ... }:

{
  xsession = {
    enable = true;

    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = rec {
        modifier = "Mod4";
        bars = [];

	gaps = {
          inner = 15;
	  outer = 5;
	};

        window = {
          border = 0;
	  hideEdgeBorders = "both";
	};

        keybindings = lib.mkOptionDefault {
          # Alacritty terminal
          "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";

          # Vim-inspired movement keys
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+h" = "focus left";
          "${modifier}+l" = "focus right";
        };

        startup = [
          {
            command = "systemctl --user restart polybar.service";
            always = true;
            notification = false;
          }
        ];
      };
    };
  };
}
