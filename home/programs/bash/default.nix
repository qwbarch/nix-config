{ pkgs, ... }:

{
  programs.bash = {
    enable = true;

    # Run neofetch if the opened terminal is the only instance.
    bashrcExtra = ''
      LIVE_COUNTER=$(ps a | awk '{print $2}' | grep -vi "tty*" | uniq | wc -l);
      if [ $LIVE_COUNTER -eq 1 ]; then
        ${pkgs.neofetch}/bin/neofetch
      fi
    '';
  };
}
