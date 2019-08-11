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
  -- xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmobarrc"
  xmonad $ def 
    { terminal = "urxvt"
    } 
 --   { manageHook = manageDocks <+> manageHook def
 --   , layoutHook = avoidStruts $ layoutHook def
 --   , logHook = dynamicLogWithPP xmobarPP 
 --     { ppOutput = hPutStrLn xmproc
 --     , ppTitle = xmobarColor "green" "" . shorten 50
 --     }
--    , modMask = mod4Mask
--    } `additionalKeys` 
--      [ (( mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
--      ]

