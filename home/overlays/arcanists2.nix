{ pkgs, lib, stdenv, autoPatchelfHook, makeWrapper }:

stdenv.mkDerivation rec {
  name = "arcanists2";
  version = "21254e_1fda44cb280f4146a4e471ac46995c81";

  src = pkgs.fetchzip {
    url = "https://400c3bfb-51ec-4397-aa27-28b8f8c30ca3.filesusr.com/archives/${version}.zip?dn=LinuxArcanists%202.zip";
    sha256 = "b73shcHwpYxT1nHi3SGiGFa1LZXXkV6egV3tzbarQYQ=";
    stripRoot = false;
  };

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = with pkgs; [ steam-run-native ];

  sourceRoot = ".";
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib
    mkdir -p $out/bin
    cp -a $src/. $out/lib
    chmod +x $out/lib/"Arcanists 2.x86_64"
    makeWrapper ${pkgs.steam-run-native}/bin/steam-run $out/bin/arcanists2 --add-flags "$out/lib/'Arcanists 2.x86_64'"
  '';

  meta = with lib; {
    homepage = "https://www.arcanists2.com";
    description = "Arcanists 2 is an online, turn-based multiplayer strategy game.";
    platforms = platforms.linux;
  };
}
