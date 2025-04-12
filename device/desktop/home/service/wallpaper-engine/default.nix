{
  services.linux-wallpaperengine = {
    enable = true;
    assetsPath = ~/.local/share/Steam/steamapps/common/wallpaper_engine/assets;
    clamping = "clamp";
    wallpapers = [
      {
        monitor = "DP-1";
        # 3461749001
        wallpaperId = "1845706469";
        fps = 144;
      }
    ];
  };
}
