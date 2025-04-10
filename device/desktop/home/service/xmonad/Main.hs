import XMonad

main = xmonad $ def
  { terminal = "alacritty"
  , modMask = mod1Mask -- Windows key.
  }