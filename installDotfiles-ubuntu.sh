#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
    echo "installing dotfiles for standard linux with a desktop environment"
    cp ./.zshrc ~/
    cp ./.bash_profile ~/
    # cp ./.xmobarrc ~/
    cp ./.Xmodmap ~/
    cp ./streamDeckrc.json ~/
    if [[ ! -d ~/.configure ]] 
      then
        mkdir ~/.configure
    fi
        if [[ ! -d ~/.config ]] 
      then
        mkdir ~/.config
    fi
    cp -ra ./.configure/* ~/.configure
    cp -ra ./.config/* ~/.config
    #if [[ ! -d ~/.xmonad ]]
    #  then
    #    mkdir ~/.xmonad
    #fi
    # cp -ra ./.xmonad/*.* ~/.xmonad
    cp ./.prettierrc ~/
    cp ./.jsbeautifyrc ~/
    cp ./.xsession ~/
    cp ./.gitconfig ~/
    cp ./.ghci ~/
    cp ./.Xmodmap ~/
    cp ./.xsession ~/
    cp ./.tmux.conf ~/
    if [[ ! -d ~/bin ]]
      then
        mkdir ~/bin
    fi
    cp ./bin/*.* ~/bin
    cp -r ./.screenlayout ~/

    echo "dotfile installation complete"
}

main
