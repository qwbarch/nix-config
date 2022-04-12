#!/bin/sh
pushd ~/.dotfiles
nix build .#homeManagerConfigurations.qwbarch.activationPackage
./result/activate
popd
