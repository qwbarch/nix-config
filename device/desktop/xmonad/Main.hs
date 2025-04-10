import XMonad
import XMonad.StackSet
import XMonad.Util.EZConfig
import XMonad.Actions.Navigation2D

main = xmonad $ def
  { terminal = "alacritty"
  , modMask = mod4Mask
  , keys = \config -> mkKeymap config $
      [ ("M-<Return>", spawn $ terminal config)
      , ("M-S-q", kill)

      -- Switch focus between windows.
      , ("M-h", windowGo L False)
      , ("M-j", windowGo D False)
      , ("M-k", windowGo U False)
      , ("M-l", windowGo R False)

      -- Helper windows.
      , ("M-d", spawn "rofi -show drun")

      -- Workspaces.
      , ("M-\\", windows $ greedyView "1")
      , ("M-<Space>", windows $ greedyView "2")
      , ("M-n", windows $ greedyView "3")
      , ("M-m", windows $ greedyView "4")
      , ("M-,", windows $ greedyView "5")
      , ("M-.", windows $ greedyView "6")
      ]
  }
