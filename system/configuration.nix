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
        gvfs.enable = true; # Nautilus file manager.
        joycond.enable = true;
        blueman.enable = true;
        getty.autologinUser = username;

        printing = {
          enable = true;
          drivers = [ pkgs.samsung-unified-linux-driver ];
          listenAddresses = [ "*:631" ];
          allowFrom = [ "all" ];
          browsing = true;
          defaultShared = true;
        };
        avahi = {
          enable = true;
          openFirewall = true;
          publish = {
            enable = true;
            userServices = true;
          };
        };

        udev.extraRules = ''
          # Nintendo Switch Pro Controller over USB hidraw
          KERNEL=="hidraw*", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="2009", MODE="0660", TAG+="uaccess"

          # Nintendo Switch Pro Controller over bluetooth hidraw
          KERNEL=="hidraw*", KERNELS=="*057E:2009*", MODE="0660", TAG+="uaccess"
        '';

        dbus = {
          enable = true;
          packages = [ pkgs.dconf ];
        };

        xserver = {
          enable = true;
          videoDrivers = [ "nvidia" ];
          layout = "us";
          xkbOptions = "caps:swapescape"; # Swap caps-lock with escape.
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

            # Enable 240hz refresh rate.
            setupCommands = "${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --mode 1920x1080 --rate 239.76";
          };

          windowManager.i3 = {
            enable = true;
            package = pkgs.i3-gaps;
          };

          config = ''
            Section "Device"
                Identifier  "Configured Video Device"
                Driver      "dummy"
                VideoRam    16384
            EndSection

            Section "Screen"
                Identifier  "Default Screen"
                Monitor     "Configured Monitor"
                Device      "Configured Video Device"
                DefaultDepth 24
                SubSection "Display"
                Depth 24
                Modes "1920x0180"
                EndSubSection
            EndSection
          '';
        };
      };

      console.useXkbConfig = true;

      hardware = {
        pulseaudio.enable = true;
        bluetooth.enable = true;
        ledger.enable = true; # Allow ledger devices to connect.
        opengl.driSupport32Bit = true; # Required for steam.
      };

      # Enable docker in rootless mode.
      virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
      };

      users.users.${username} = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" "audio" "docker" ];
        packages = with pkgs; [ ];
      };

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;

      environment = {
        # List packages installed in system profile. To search, run:
        # $ nix search wget
        systemPackages = with pkgs; [
          git
          docker-compose
          gnome.adwaita-icon-theme
          gnome.nautilus
          xorg.libXtst
        ];

        # Disable gui prompt when git asks for a password.
        extraInit = ''
          unset -v SSH_ASKPASS
        '';
      };

      fonts.fonts = with pkgs; [ nerdfonts ];

      # Open ports in the firewall.
      networking.firewall.allowedTCPPorts = [ 3000 8080 ];
      # networking.firewall.allowedUDPPorts = [ ... ];

      nix = {
        package = pkgs.nixFlakes;
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 90d";
        };
        settings = {
          auto-optimise-store = true;
          keep-outputs = true;
          keep-derivations = true;
          experimental-features = [ "nix-command" "flakes" ];
          trusted-public-keys = [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
            "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
          ];
          substituters = [
            "https://cache.nixos.org"
            "https://cache.iog.io"
            "https://ai.cachix.org"
          ];
        };
      };

      system.stateVersion = stateVersion;
    }];
  };
}
