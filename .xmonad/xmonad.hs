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
    { terminal = "kitty"
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
      [ (( mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
      ]

myStartupHook = do
  spawnOnce "kitty &"
  spawnOnce "stalonetray --config ~/.stalonetrayrc &"

xmobarEscape = concatMap doubleLts
  where 
    doubleLts '<' = "<<"
    doubleLts x = [x]

myWorkSpaces :: [String]
myWorkSpaces = 
  ["1:Terms", "2:Web", "3:Slack", "4", "5", "6", "7", "8", "9"]

clickable l = 
  [ "<action=xdotool key alt+" ++ 
       show (n) ++ ">" ++ ws ++ "</action>" 
    | (i, ws) <- zip [1..9] l
    , let n = i ]
-- wishlist 
-- 2. hotkey for selective screenshot - assign to "flameshot gui"
-- 3. hotkey for tile screenshot
-- 4. hotkey to cycle through workspaces
