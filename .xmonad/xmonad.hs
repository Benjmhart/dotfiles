-------------------------------------------------------------------
-- ~/.xmonad/xmonad.hs
-- validate syntax: `ghcid` or `xmonad --recompile`
{-# LANGUAGE NoMonomorphismRestriction #-}
-------------------------------------------------------------------
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.SpawnOnce
import System.IO 
import XMonad.Layout.IndependentScreens

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmobarrc"
  xmonad $ def 
    { terminal = "konsole"
    , manageHook = manageDocks <+> manageHook def
    , startupHook = myStartupHook
    , layoutHook = avoidStruts $ layoutHook def
    , logHook = dynamicLogWithPP xmobarPP 
      { ppOutput = hPutStrLn xmproc
      , ppTitle = xmobarColor "green" "" . shorten 50
      }
    , handleEventHook = handleEventHook def <+> docksEventHook
    , modMask = mod4Mask -- rebind mod to the windows key
    } `additionalKeys` 
      [ printscreenFlameshot
      , modKKeypass
      ]

printscreenFlameshot = ((noModMask, xK_Print), spawn "flameshot gui")
modKKeypass = ((mod4Mask .|. shiftMask, xK_k), spawn "keepassxc")

myStartupHook = do
  spawnOnce "konsole &"
  spawnOnce "stalonetray --config ~/.stalonetrayrc &"

-- wishlist 
-- 3. hotkey for tile screenshot
-- 4. hotkey to cycle through workspaces
