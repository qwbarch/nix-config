#!/usr/bin/env bash

sudo nixos-rebuild switch --flake .#
xmonad --recompile
xmonad --restart
