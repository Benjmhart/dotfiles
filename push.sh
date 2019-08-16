#!/usr/bin/env bash

echo "push"


# this is intended as a cron job that runs updates automatically for dotfiles and for a secrets repo

main() {
    DATE=`date +%Y-%m-%d`
    echo "cron task started $DATE" > ~/Desktop/cronLog.txt

    cp ~/.config/Code/User/keybindings.json ~/dotfiles/.config/Code/User/keybindings.json
    cp ~/.config/Code/User/settings.json ~/dotfiles/.config/Code/User/settings.json
    cp -r ~/.config/nvim ~/dotfiles/.config/nvim
    cp -r ~/.config/kitty ~/dotfiles/.config/
    cp -r ~/.config/synergy ~/dotfiles/.config/synergy
    cp -r ~/.config/teamviewer ~/dotfiles/.config/teamviewer
    cp -r ~/.config/teamviewer ~/dotfiles/.config/teamviewer
    cp -r ~/.config/zathura ~/dotfiles/.config/zathura
    cp -r ~/.configure/*.* ~/dotfiles/.configure
    cp ~/.ghci ~/dotfiles
    cp ~/.configure/nvim/init.vim ~/dotfiles
    cp ~/.zshrc ~/dotfiles
    cp ~/streamDeckrc.json ~/dotfiles
    cp ~/.prettierrc ~/dotfiles
    cp ~/.jsbeautifyrc ~/dotfiles
    cp ~/.Xmodmap ~/dotfiles
    cp ~/.xsession ~/dotfiles

    ( cd ~/secrets && git add . && git commit -m $DATE && git push origin master )

    ( cd ~/dotfiles && git add . && git commit -m $DATE && git push origin master )
    
    echo "TASK COMPLETE"
    echo "cron task ran successfully $DATE" >> ~/Desktop/cronLog.txt
}

main
