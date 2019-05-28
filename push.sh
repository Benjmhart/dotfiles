#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
    DATE=`date +%Y-%m-%d`
    echo "cron task started $DATE" > ~/Desktop/cronLog.txt
    cp ~/Passwords.kdbx ~/dotfiles
    echo "line 10"
    cp -r ~/.config/Code/User/* ~/dotfiles/vscode
    echo "line 12"
    cp ~/.ghci ~/dotfiles
    cp ~/.vimrc ~/dotfiles
    cp ~/.zshrc ~/dotfiles
    echo "got this far"

    ( cd ~/dotfiles && git add . && git commit -m $DATE && git push origin master )
    echo "TASK COMPLETE"
    echo "cron task ran successfully $DATE" >> ~/Desktop/cronLog.txt
}

main
