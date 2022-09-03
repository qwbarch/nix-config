# NixOS configuration

The following instructions assumes you're running on a non-graphical, fresh installation of NixOS.  
While a non-graphical installation is not neccessary, I prefer it as my initial choice.

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
git clone https://github.com/qwbarch/dotfiles ~/dotfiles
```

## Running the system build

Before you build your system, you will need to copy over your own ``hardware-configuration.nix`` to the cloned repository.  
```
cp /etc/nixos/hardware-configuration.nix ~/dotfiles/system/hardware-configuration.nix
```

Run the system build:
```
sudo nixos-rebuild switch --flake .#edward-nixos
```

Once the system build is finished, reboot your system.

## Running the home manager build

You will now have i3-gaps installed with the default settings.  
On launch, i3 should ask if you want to use the ``windows`` or ``alt`` key as your default ``modifier key``.

After selecting your modifier key, press the following keys to open a terminal window:
```
{modifier_key} + enter
```

Before you run the home manager build, I recommend deleting the configuration files your system comes with by default.  
Why? NixOS automatically attempts to rebuild your system with the default configuration if you leave it there.
```
sudo rm -r /etc/nixos
```

Run the home manager build:
```
~/dotfiles/switch home
```

Once the build is complete, reboot your system and it's ready to be used!
