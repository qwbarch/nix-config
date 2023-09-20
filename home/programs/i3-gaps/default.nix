{ pkgs, lib, ... }:

let
  modifier = "Mod4";
  workspace = {
    terminal = "terminal";
    code = "code";
    browser = "browser";
    spotify = "spotify";
    discord = "discord";
    bitwarden = "bitwarden";
    signal = "signal";
    ledger = "ledger";
    extra = "extra";
    steam = "steam";
    steam-app = "steam-app";
  };
in
{
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      config = {
        inherit modifier;

        bars = [ ];

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

            # Bind steam workspace.
            {
              command = "move to workspace ${workspace.steam}; floating enable";
              criteria = { class = "steam"; };
            }

            # Bind Path of Exile to steam-app workspace.
            {
              command = "move to workspace ${workspace.steam-app};fullscreen enable";
              criteria = { class = "steam_app_238960"; };
            }

            {
              command = "floating enable";
              criteria = { class = "awakened-poe-trade"; };
            }
          ];
        };

        gaps = {
          inner = 10;
          outer = 5;
        };

        keybindings = {
          # Alacritty terminal
          "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";

          # Rofi
          "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun";

          # Screenshot
          "${modifier}+shift+s" = "exec ${pkgs.flameshot}/bin/flameshot gui -c";
          "${modifier}+shift+a" = "exec ${pkgs.flameshot}/bin/flameshot gui";

          # Movement
          "${modifier}+j" = "focus down";
          "${modifier}+k" = "focus up";
          "${modifier}+h" = "focus left";
          "${modifier}+l" = "focus right";

          # Workspaces
          "${modifier}+space" = "workspace ${workspace.terminal}";
          "${modifier}+m" = "workspace ${workspace.code}";
          "${modifier}+comma" = "workspace ${workspace.browser}";
          "${modifier}+period" = "workspace ${workspace.bitwarden}";
          "${modifier}+slash" = "workspace ${workspace.spotify}";
          "${modifier}+u" = "workspace ${workspace.discord}";
          "${modifier}+i" = "workspace ${workspace.signal}";
          "${modifier}+o" = "workspace ${workspace.ledger}";
          "${modifier}+p" = "workspace ${workspace.extra}";
          "${modifier}+bracketright" = "workspace ${workspace.steam}";
          "${modifier}+backslash" = "workspace ${workspace.steam-app}";

          # Misc
          "${modifier}+shift+q" = "kill";
          "${modifier}+f" = "fullscreen toggle";
          "${modifier}+z" = "split h";
          "${modifier}+x" = "split v";
          "${modifier}+r" = "mode resize";
        };

        assigns = {
          ${workspace.code} = [{ class = "Code"; }];
          ${workspace.browser} = [{ class = "Chromium-browser"; }];
          ${workspace.bitwarden} = [{ class = "Bitwarden"; }];
          ${workspace.discord} = [{ class = "discord"; }];
          ${workspace.signal} = [{ class = "Signal"; }];
          ${workspace.ledger} = [{ class = "Ledger Live"; }];
          ${workspace.steam} = [{ class = "^Steam$"; }];
        };

        modes.resize = {
          "h" = "resize grow width 10 px or 10 ppt";
          "j" = "resize shrink height 10 px or 10 ppt";
          "k" = "resize grow height 10 px or 10 ppt";
          "l" = "resize shrink width 10 px or 10 ppt";
          "Escape" = "mode default";
        };

        startup = [
          {
            command = "${pkgs.xmousepasteblock}/bin/xmousepasteblock";
            always = true;
            notification = false;
          }
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
            command = "${pkgs.chromium}/bin/chromium --restore-last-session";
            always = false;
            notification = false;
          }
          {
            command = "${pkgs.unstable.bitwarden}/bin/bitwarden";
            always = false;
            notification = false;
          }
          {
            command = "${pkgs.unstable.spotify}/bin/spotify";
            always = false;
            notification = false;
          }
          {
            command = "${pkgs.unstable.ledger-live-desktop}/bin/ledger-live-desktop";
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
          {
            command = "${pkgs.steam}/bin/steam";
            always = false;
            notification = false;
          }
          {
            command = "${pkgs.awakened-poe-trade}/bin/awakened-poe-trade";
            always = false;
            notification = false;
          }
        ];
      };
    };
  };
  home.file.".background.webp".source = ./background.webp;
}
