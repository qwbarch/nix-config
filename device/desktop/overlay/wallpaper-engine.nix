{ config, lib, pkgs, username, ...}:

let 
  # References: https://gist.github.com/BBArikL/b389c4592d636380523e03ac423b77b3
  glslang-submodule = with pkgs; stdenv.mkDerivation {
    name = "glslang";
    installPhase = ''
      mkdir -p $out
    '';
    src = fetchFromGitHub {
      owner = "KhronosGroup";
      repo = "glslang";
      rev = "c34bb3b6c55f6ab084124ad964be95a699700d34";
      sha256 = "IMROcny+b5CpmzEfvKBYDB0QYYvqC5bq3n1S4EQ6sXc=";
    };
  };

  wallpaper-engine-kde-plugin = with pkgs; stdenv.mkDerivation rec {
    pname = "wallpaperEngineKde";
    version = "96230de92f1715d3ccc5b9d50906e6a73812a00a";
    src = fetchFromGitHub {
      owner = "Jelgnum";
      repo = "wallpaper-engine-kde-plugin";
      rev = version;
      hash = "sha256-vkWEGlDQpfJ3fAimJHZs+aX6dh/fLHSRy2tLEsgu/JU=";
      fetchSubmodules = true;
        };

    nativeBuildInputs = [
      cmake
      kdePackages.extra-cmake-modules
      glslang-submodule
      pkg-config
      gst_all_1.gst-libav
      shaderc
      ninja
    ];

    buildInputs = [
      mpv
      lz4
      vulkan-headers
      vulkan-tools
      vulkan-loader
    ] 
    ++ (with kdePackages; with qt6Packages; [
      qtbase
      qt6.full
      kpackage
      kdeclarative
      libplasma
      qtwebsockets
      qtwebengine
      qtwebchannel
      qtmultimedia
      qtdeclarative
    ])
    ++ [(python3.withPackages (python-pkgs: [ python-pkgs.websockets ]))];

    cmakeFlags = [ "-DUSE_PLASMAPKG=OFF" ];
    dontWrapQtApps = true;

    postPatch = ''
      rm -rf src/backend_scene/third_party/glslang
      ln -s ${glslang-submodule.src} src/backend_scene/third_party/glslang
    '';
    #Optional informations
    meta = with lib; {
      description = "Wallpaper Engine KDE plasma plugin";
      homepage = "https://github.com/Jelgnum/wallpaper-engine-kde-plugin";
      license = licenses.gpl2Plus;
      platforms = platforms.linux;
    };
  };
in 

{
  options.nixos = {
    pkgs.wallpaper-engine-kde-plugin = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        example = true;
        description = "Enable wallpaper-engine-kde-plugin.";
      };
    };
  };

  config = lib.mkIf (config.nixos.pkgs.wallpaper-engine-kde-plugin.enable) {
    environment.systemPackages = with pkgs; [
      wallpaper-engine-kde-plugin
      kdePackages.qtwebsockets
      kdePackages.qtwebchannel
      (python3.withPackages (python-pkgs: [ python-pkgs.websockets ]))
    ];

    system.activationScripts = {
      wallpaper-engine-kde-plugin.text = ''
        wallpaperenginetarget=/share/plasma/wallpapers/com.github.catsout.wallpaperEngineKde
        mkdir -p /home/${username}/.local/share/plasma/wallpapers
        chown -R ${username}:users /home/${username}/.local/share/plasma
        ln -sf ${wallpaper-engine-kde-plugin}/$wallpaperenginetarget /home/${username}/.local/$wallpaperenginetarget
      '';
    };
  };
}
