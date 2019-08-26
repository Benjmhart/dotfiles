xrdb -merge .Xresources


xsetroot -solid midnightblue


# Set background image with feh
# feh --bg-scale ~/dotfiles/bg/valley.jpg &
nitrogen --set-scaled --random ~/dotfiles/bg

#screensaver -no-splash &
nm-applet --sm-disable &
flameshot &
cbatticon &
xfce4-power-manager &
udiskie & 
compton &
volumeicon & 
xmodmap ~/.Xmodmap

exec xmonad
