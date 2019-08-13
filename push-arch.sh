#!/usr/bin/env bash




# this is intended as a cron job that runs updates automatically for dotfiles and for a secrets repo

main() {
    DATE=`date +%Y-%m-%d`
    echo "cron task started $DATE" > ~/Desktop/cronLog.txt

    cp ~/.config/Code/User/keybindings.json ~/dotfiles/.config/Code/User/keybindings.json
    cp ~/.config/Code/User/settings.json ~/dotfiles/.config/Code/User/settings.json
    cp -r ~/.config/nvim ~/dotfiles/.config
    cp -r ~/.config/kitty ~/dotfiles/.config
    cp -r ~/.config/synergy ~/dotfiles/.config
    cp -r ~/.config/teamviewer ~/dotfiles/.config
    cp -r ~/.config/teamviewer ~/dotfiles/.config
    cp -r ~/.config/zathura ~/dotfiles/.config
    cp -r ~/.configure/*.* ~/dotfiles/.configure
    cp -r ~/.xmonad ~/dotfiles
    cp ~/.xinitrc ~/dotfiles
    cp ~/.xmovar ~/dotfiles
    cp ~/.ghci ~/dotfiles
    cp ~/.zshrc ~/dotfiles
    cp ~/streamDeckrc.json ~/dotfiles
    cp ~/.prettierrc ~/dotfiles
    cp ~/.jsbeautifyrc ~/dotfiles
    cp ~/.hyper.js ~/dotfiles
    cp ~/.Xmodmap ~/dotfiles
    cp ~/.xsession ~/dotfiles

    ( cd ~/secrets && git add . && git commit -m $DATE && git push origin master )

    ( cd ~/dotfiles && git add . && git commit -m $DATE && git push origin master )
    
    echo "TASK COMPLETE"
    [[ -d ~/Desktop ]] && echo "cron task ran successfully $DATE" >> ~/Desktop/cronLog.txt
}

main
