#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
    echo "installing dotfiles"
    cp ./.zshrc ~/
    cp ./streamDeckrc.json ~/
    cp ./.vimrc ~/
    cp ./.prettierrc ~/
    cp ./.jsbeautifyrc ~/
    cp ./.hyper.js ~/
    cp ./.gitignore ~/
    cp ./.ghci ~/
    
    if [[ ! -d "~/bin" ]] 
      then
        mkdir "~/bin"
    fi

    cp ./bin/sudovim ~/bin
    cp ./bin/title ~/bin

    echo "dotfile installation complete"
}

main
