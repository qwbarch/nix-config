{ pkgs, lib, system, username, hostName, stateVersion, ... }:

{
  ${hostName} = lib.nixosSystem {
    inherit system;
    modules = [{
      imports = [ ./hardware-configuration.nix ];

      # Bootloader.
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.efi.efiSysMountPoint = "/boot/efi";

      networking = {
        inherit hostName;
        networkmanager.enable = true;
      };

      # Set your time zone.
      time.timeZone = "EST5EDT";

      # Select internationalisation properties.
      i18n.defaultLocale = "en_US.utf8";

      services = {
        dbus = {
          enable = true;
          packages = [ pkgs.dconf ];
        };

        xserver = {
          enable = true;
          layout = "us";
          xkbOptions = "caps:swapescape"; # Swap caps-lock with escape.
          videoDrivers = [ "nvidia" ];
          libinput = {
            enable = true;
            mouse = {
              accelProfile = "flat"; # Disable acceleration.
              middleEmulation = false; # Disable emulating middle click using left + right clicks;
            };
          };

          displayManager = {
            defaultSession = "none+i3";
            sddm.autoNumlock = true;

            autoLogin = {
              enable = true;
              user = username;
            };
          };

          windowManager.i3 = {
            enable = true;
            package = pkgs.i3-gaps;
          };
        };
      };

      console.useXkbConfig = true;

      hardware = {
        pulseaudio.enable = true;
        bluetooth.enable = true;
        ledger.enable = true; # Allow ledger devices to connect.
      };
      services.blueman.enable = true;

      users.users.${username} = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" "audio" ];
        packages = with pkgs; [ ];
      };
      services.getty.autologinUser = username;

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      environment = {
        # List packages installed in system profile. To search, run:
        # $ nix search wget
        systemPackages = with pkgs; [ git ];

        # Disable gui prompt when git asks for a password.
        extraInit = ''
          unset -v SSH_ASKPASS
        '';
      };

      fonts.fonts = with pkgs; [ nerdfonts ];

      # Open ports in the firewall.
      # networking.firewall.allowedTCPPorts = [ ... ];
      # networking.firewall.allowedUDPPorts = [ ... ];

      nix = {
        package = pkgs.nixFlakes;
        settings.auto-optimise-store = true;
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };
        extraOptions = ''
          experimental-features = nix-command flakes

          # Hydra server for haskell.nix
          trusted-public-keys = cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY= hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ=
          substituters = https://cache.nixos.org https://hydra.iohk.io
        '';
      };

      system.stateVersion = stateVersion;
    }];
  };
}
