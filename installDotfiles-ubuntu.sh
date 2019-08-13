#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
    echo "installing dotfiles for standard linux with a desktop environment"
    cp ./.zshrc ~/
    cp ./.bash_profile ~/
    # cp ./xmobarrc ~/
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
    cp -r ./.configure/*.* ~/.configure
    cp -r ./config/*.* ~/.config
    # cp -r ./.xmonad ~/
    cp ./.prettierrc ~/
    cp ./.jsbeautifyrc ~/
    cp ./.xsession ~/
    cp ./.gitconfig ~/
    cp ./.ghci ~/
    cp ./.Xmodmap ~/
    cp ./.xsession ~/
    cp ./bin/*.* ~/bin
    cp ./.screenlayout ~/

    echo "dotfile installation complete"
}

main
