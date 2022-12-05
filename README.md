# NixOS configuration

The following instructions assumes you're running on a non-graphical, fresh installation of NixOS.  
While a non-graphical installation is not neccessary, I prefer it as my initial choice.

![desktop](https://i.redd.it/b96t7sb4nll91.png)

## Preparing the system build

Connect to the internet via ``nmcli``:
```
nmcli device wifi connect <wifi_name> password <wifi_password>
```

Add ``git`` to your current bash session:
```
nix-shell -p git
```

Clone the repository to your home directory:
```
git clone https://github.com/qwbarch/nix-config ~/nix-config
```

## Running the system build

Before you build your system, you will need to copy over your own ``hardware-configuration.nix`` to the cloned repository.  
```
cp /etc/nixos/hardware-configuration.nix ~/nix-config/system/hardware-configuration.nix
```

Run the system build:
```
cd ~/nix-config && sudo nixos-rebuild switch --flake .#edward-nixos
```

Once the system build is finished, reboot your system.

## Running the home manager build

You will now have i3-gaps installed. A prompt will ask if you'd like to generate a new config.  
Simply press ``esc`` to use the default settings.

Next, open up terminal using the following hotkeys:
```
alt + enter
```

Before you run the home manager build, I recommend deleting the configuration files your system comes with by default.  
Why? NixOS automatically attempts to rebuild your system with the default configuration if you leave it there.
```
sudo rm -r /etc/nixos
```

Run the home manager build:
```
~/nix-config/switch home
```

Once the build is complete, reboot your system and it's ready to be used!

### Note to self

If a binary cache is down, remove the cache from the relevant config files and run the following:
```
nix build .#homeManagerConfiguration.qwbarch.activationPackage -fallback --show-trace --option binary-caches https://cache.nixos.org/
```
