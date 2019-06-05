#!/usr/bin/env bash

set -o errexit
set -o nounset


# this is intended as a cron job that runs updates automatically for dotfiles and for a secrets repo

main() {
    DATE=`date +%Y-%m-%d`
    echo "cron task started $DATE" > ~/Desktop/cronLog.txt
    cp ~/Passwords.kdbx ~/secrets

    cp -r ~/.config/Code/User/settings.json ~/dotfiles/vscode
    cp -r ~/.config/Code/User/keybindings.json ~/dotfiles/vscode
    cp ~/.ghci ~/dotfiles
    cp ~/.vimrc ~/dotfiles
    cp ~/.zshrc ~/dotfiles
    cp ~/streamDeckrc.json ~/dotfiles
    cp ~/.prettierrc ~/dotfiles
    cp ~/.jsbeautifyrc ~/dotfiles
    cp ~/.hyper.js ~/dotfiles

    (cd ~/secrets && git add . && git commit -m $DATE && git push origin master)

    ( cd ~/dotfiles && git add . && git commit -m $DATE && git push origin master )
    
    echo "TASK COMPLETE"
    echo "cron task ran successfully $DATE" >> ~/Desktop/cronLog.txt
}

main
