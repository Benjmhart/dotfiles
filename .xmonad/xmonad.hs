-------------------------------------------------------------------
-- ~/.xmonad/xmonad.hs
-- validate syntax: `ghcid` or `xmonad --recompile`
{-# LANGUAGE NoMonomorphismRestriction #-}
-------------------------------------------------------------------
import XMonad
import XMonad.Actions.SpawnOn (spawnOn)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.StackSet as W
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.SpawnOnce
import System.IO 
import XMonad.Layout.IndependentScreens

main = do
  xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmobarrc"
  xmonad $ def 
    { terminal = "konsole"
    , manageHook = myManageHook <+> manageDocks 
    , startupHook = myStartupHook
    , layoutHook = avoidStruts $ layoutHook def
    , logHook = dynamicLogWithPP xmobarPP 
      { ppOutput = hPutStrLn xmproc
      , ppTitle = xmobarColor "green" "" . shorten 50
      }
    , handleEventHook = handleEventHook def <+> docksEventHook
    , modMask = mod4Mask -- rebind mod to the windows key
    } `additionalKeys` 
      myKeys

myManageHook 
  = composeAll
    [ className =? "Google-chrome" --> doShift "4"
    , className =? "Slack" --> doShift "5"
    ]

printscreenFlameshot = ((noModMask, xK_Print), spawn "flameshot gui")
modKKeypass = ((mod4Mask .|. shiftMask, xK_k), spawn "keepassxc")
-- alt is mod1Mask
modKScreenmap = [((mod4Mask .|. mod1Mask, key), screenWorkspace sc >>= flip whenJust (windows . f))
  | (key, sc) <- zip [xK_w, xK_e, xK_r] [1, 0, 2]
  , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
myKeys 
  = concat 
    [ [printscreenFlameshot
      , modKKeypass
      ]
    -- , modKScreenmap
    ]

myStartupHook = do
  spawnOnce "konsole &"
  spawnOnce "copyq &"
  spawnOnce "stalonetray --config ~/.stalonetrayrc &"
  spawnOn "4" "google-chrome-stable"
  spawnOn "5" "slack"

-- wishlist 
-- 3. hotkey for tile screenshot
-- 4. hotkey to cycle through workspaces
