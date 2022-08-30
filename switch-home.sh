#!/bin/sh
pushd ~/dotfiles
nix build .#homeManagerConfiguration.qwbarch.activationPackage
./result/activate
popd
