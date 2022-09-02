{ pkgs, lib, ... }:

let
  modifier = "Mod4";
  workspace = {
    terminal = "10";
    code = "1";
    browser = "2";
    spotify = "7";
    discord = "8";
    bitwarden = "9";
  };
in
{
  xsession = { enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        inherit modifier;

        bars = [];

	window = {
          border = 0;
	  hideEdgeBorders = "both";

	  commands = [
	    # Start chromium in fullscreen by default.
	    {
	      command = "fullscreen enable";
	      criteria = { class = "Chromium-browser"; };
	    }

	    # Start vscode in fullscreen by default.
	    {
              command = "fullscreen enable";
	      criteria = { class = "Code"; };
	    }

	    # Bind spotify workspace.
	    # This is a workaround for spotify not working with "assigns".
	    {
	      command = "move to workspace ${workspace.spotify}";
	      criteria = { class = "Spotify"; };
	    }
	  ];
	};

	gaps = {
          inner = 10;
	  outer = 5;
	};

        keybindings = lib.mkOptionDefault {
          # Alacritty terminal
          "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";

	  # Rofi
	  "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun -display-drun Search";

          # Screenshot
	  "${modifier}+shift+s" = "exec ${pkgs.flameshot}/bin/flameshot gui -c";

          # Vim-inspired movement keys
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+h" = "focus left";
          "${modifier}+l" = "focus right";

	  # Workspaces
        };

	assigns = {
	  ${workspace.code} = [ { class = "Code"; } ];
          ${workspace.browser} = [ { class = "Chromium-browser"; } ];
	  ${workspace.bitwarden} = [ { class = "Bitwarden"; } ];
	  ${workspace.discord} = [ { class = "discord"; } ];
	};

        startup = [
	  {
            command = "${pkgs.feh}/bin/feh --bg-fill ~/.background.webp";
	    always = true;
	    notification = false;
	  }
          {
            command = "systemctl --user restart polybar.service";
            always = true;
            notification = false;
          }
	  {
	    command = "${pkgs.xbanish}/bin/xbanish";
	    always = true;
	    notification = false;
	  }
	  {
            command = "${pkgs.chromium}/bin/chromium";
	    always = false;
	    notification = false;
	  }
	  {
	    command = "${pkgs.bitwarden}/bin/bitwarden";
	    always = false;
	    notification = false;
	  }
	  {
	    command = "${pkgs.spotify}/bin/spotify";
	    always = false;
	    notification = false;
	  }
	  { 
	    command = "${pkgs.i3}/bin/i3-msg workspace ${workspace.terminal}";
	    always = false;
	    notification = false;
	  }
	  {
	    command = "${pkgs.alacritty}/bin/alacritty";
	    always = false;
	    notification = false;
	  }
        ];
      };
    };
  };
  home.file.".background.webp".source = ./background.webp;
}
