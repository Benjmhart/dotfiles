xrdb -merge .Xresources


xsetroot -solid midnightblue


# Set background image with feh
feh --bg-scale ~/dotfiles/bg/valley.jpg &

#screensaver -no-splash &
#stalonetray &
nm-applet --sm-disable &
flameshot &
cbatticon &
xfce4-power-manager &
udiskie & 
compton &
volumeicon & 
xmodmap ~/.Xmodmap

exec xmonad
