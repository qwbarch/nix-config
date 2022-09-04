{ writeShellScript, lib, coreutils, playerctl, ... }:

# Credits: https://github.com/PrayagS/polybar-spotify
writeShellScript "polybar-spotify.sh" ''
  PATH=${lib.makeBinPath [ coreutils playerctl ]}
  FORMAT="{{ title }} - {{ artist }}"

  PLAYERCTL_STATUS=$(playerctl --player=spotify status 2>/dev/null)
  EXIT_CODE=$?

  if [ $EXIT_CODE -eq 0 ]; then
    STATUS=$PLAYERCTL_STATUS
  else
    STATUS="Inactive"
  fi

  if [ "$1" == "--status" ]; then
    echo "$STATUS"
  else
    if [[ "$STATUS" = @(Stopped|Paused|Inactive) ]]; then
      echo " "
    else
      playerctl --player=spotify metadata --format "$FORMAT"
    fi
  fi
''
