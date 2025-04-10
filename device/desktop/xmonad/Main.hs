import XMonad
import XMonad.Util.EZConfig
import XMonad.Actions.Navigation2D

--modMask = mod4Mask -- Windows key.

main = xmonad $ def
  { terminal = "alacritty"
  , modMask = mod4Mask
  , keys = \config -> mkKeymap config $
      [ ("M-<Return>", spawn $ terminal config)
      , ("M-S-q", kill)

      , ("M-h", windowGo L False)
      , ("M-j", windowGo D False)
      , ("M-k", windowGo U False)
      , ("M-l", windowGo R False)
      ]
  }
