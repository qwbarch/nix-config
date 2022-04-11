#!/bin/sh
pushd ~/.dotfiles
home-manager switch -f ./users/qwbarch/home.nix
popd
