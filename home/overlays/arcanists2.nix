{ pkgs, lib, stdenv, autoPatchelfHook }:

stdenv.mkDerivation rec {
  name = "arcanists2";
  version = "21254e_1fda44cb280f4146a4e471ac46995c81";

  src = pkgs.fetchzip {
    url = "https://400c3bfb-51ec-4397-aa27-28b8f8c30ca3.filesusr.com/archives/${version}.zip?dn=LinuxArcanists%202.zip";
    sha256 = "b73shcHwpYxT1nHi3SGiGFa1LZXXkV6egV3tzbarQYQ=";
    stripRoot = false;
  };

  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = with pkgs; [
    zlib
    gtk3
  ];

  sourceRoot = ".";
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    mkdir -p $out/lib
    cp -a $src/. $out/lib
    install -m755 -D "$out/lib/Arcanists 2.x86_64" $out/bin/arcanists2
  '';
}
