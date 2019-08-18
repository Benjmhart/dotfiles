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
import System.IO 

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmobarrc"
  xmonad $ def 
    { terminal = "kitty"
    , manageHook = manageDocks <+> manageHook def
    , layoutHook = avoidStruts $ layoutHook def
    , logHook = dynamicLogWithPP xmobarPP 
      { ppOutput = hPutStrLn xmproc
      , ppTitle = xmobarColor "green" "" . shorten 50
      }
    , handleEventHook = handleEventHook def <+> docksEventHook
    , modMask = mod4Mask -- rebind mod to the windows key
    } `additionalKeys` 
      [ (( mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
      ]
-- wishlist 
-- 2. hotkey for selective screenshot - assign to "flameshot gui"
-- 3. hotkey for tile screenshot
-- 4. hotkey to cycle through workspaces
