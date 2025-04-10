{
  services.linux-wallpaperengine = {
    enable = true;
    assetsPath = ~/.local/share/Steam/steamapps/common/wallpaper_engine/assets;
    clamping = "clamp";
    wallpapers = [
      {
        monitor = "DP-1";
        wallpaperId = "2370927443";
        fps = 144;
      }
    ];
  };
}
