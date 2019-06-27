#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
    echo "installing dotfiles"
    cp ./.zshrc ~/
    cp ./streamDeckrc.json ~/
    cp ./.vimrc ~/
    if [[ ! -d ~/.configure ]] 
      then
        mkdir ~/.configure
    fi
        if [[ ! -d ~/.configure/nvim ]] 
      then
        mkdir ~/.configure/nvim
    fi
    cp ./init.vim ~/.configure/nvim/
    cp ./.prettierrc ~/
    cp ./.jsbeautifyrc ~/
    cp ./.hyper.js ~/
    cp ./.gitignore ~/
    cp ./.ghci ~/
    cp ./.Xmodmap ~/
    cp ./.xsession ~/

    if [[ ! -d ~/bin ]] 
      then
        mkdir ~/bin
    fi

    cp ./bin/sudonvm ~/bin
    cp ./bin/title ~/bin

    if [[ ! -d ~/.screenlayout ]] 
      then
        mkdir ~/.screenlayout
    fi

    cp ./.screenlayout/single.sh ~/.screenlayout
    cp ./.screenlayout/tripleThreat.sh ~/.screenlayout
    cp ./.screenlayout/wide.sh ~/.screenlayout

    if [[ ! -d ~/.config ]]
      then
        mkdir ~/.config
    fi

    if [[ ! -d ~/.config/Code ]]
      then 
        mkdir ~/.config/Code
    fi

    if [[ ! -d ~/.config/Code/User ]] 
      then
        mkdir ~/.config/Code/User
    fi

    cp -r ./vscode/* ~/.config/Code/User

    echo "dotfile installation complete"
}

main
