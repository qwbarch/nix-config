{ pkgs, lib, stdenv, autoPatchelfHook, makeWrapper, fetchurl }:

let
  name = "awakened-poe-trade";
  version = "3.22.10003";
  description = "Path of Exile trading app";
  desktopEntry = ''
    [Desktop Entry]
    Type=Application
    Version=${version}
    Name=Awakened PoE Trade
    GenericName=${description}
    Icon=/share/applications/awakened-poe-trade.png
    Exec=${name}
    Terminal=false
    Categories=Game
  '';
  file = "Awakened-PoE-Trade-${version}.AppImage";

  icon = pkgs.fetchurl {
    url = "https://camo.githubusercontent.com/6b2c72a3525f969797bf0713c8ffbc76a4c01337f8b1870c3b867e447120798b/68747470733a2f2f7765622e706f6563646e2e636f6d2f696d6167652f4172742f32444974656d732f43757272656e63792f5472616e736665724f72622e706e67";
    sha256 = "sha256-IxLgYdZyFw6N+It0QNDtgmThaozpfyOOgD2k2zPyh8A=";
  };
in
pkgs.appimageTools.wrapType2 {
  name = "awakened-poe-trade";
  src = fetchurl {
    url = "https://github.com/SnosMe/awakened-poe-trade/releases/download/v${version}/${file}";
    hash = "sha256-b+cDOmU0s0MqP5ZgCacmAon8UqDejG4HcOqi+Uf2dEM=";
  };

  extraInstallCommands = ''
    mkdir -p $out/share/applications
    cp ${icon} $out/share/applications/awakened-poe-trade.png
    echo "${desktopEntry}" > $out/share/applications/${name}.desktop
    substituteInPlace $out/share/applications/awakened-poe-trade.desktop --replace /share/ $out/share/
  '';
}
