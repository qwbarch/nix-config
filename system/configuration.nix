{ config, pkgs, ... }:

let
  user = "qwbarch";
in 
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "edward-nixos";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

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
      xkbOptions = "caps:swapescape";
      videoDrivers = [ "nvidia" ];
      libinput.enable = true;

      displayManager = {
        defaultSession = "none+i3";
	sddm.autoNumlock = true;

	autoLogin = {
          enable = true;
	  user = "qwbarch";
	};
      };

      windowManager.i3 = {
        enable = true;
	package = pkgs.i3-gaps;
      };
    };
  };

  console.useXkbConfig = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
  services.getty.autologinUser = user;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment = {
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs; [
      git
    ];
   
    # Disable gui prompt when git asks for a password.
    extraInit = ''
      unset -v SSH_ASKPASS
    '';
  };

  fonts.fonts = with pkgs; [
    font-awesome
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
