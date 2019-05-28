#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
    DATE=`date +%Y-%m-%d`
    echo "cron task started $DATE" > ~/Desktop/cronLog.txt
    cp ~/Passwords.kdbx ~/dotfiles
    cp -r ~/.config/Code/User/settings.json ~/dotfiles/vscode
    cp -r ~/.config/Code/User/keybindings.json ~/dotfiles/vscode
    cp ~/.ghci ~/dotfiles
    cp ~/.vimrc ~/dotfiles
    cp ~/.zshrc ~/dotfiles
    cp ~/streamDeckrc.json ~/dotfiles
    cp ~/.prettierrc ~/dotfiles
    cp ~/.jsbeautifyrc ~/dotfiles
    cp ~/.hyper.js ~/dotfiles

    ( cd ~/dotfiles && git add . && git commit -m $DATE && git push origin master )
    
    echo "TASK COMPLETE"
    echo "cron task ran successfully $DATE" >> ~/Desktop/cronLog.txt
}

main
