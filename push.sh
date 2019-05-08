#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
    DATE=`date +%Y-%m-%d`

    ( cd ~/dotfiles && git add . && git commit -m $DATE && git push origin master )
}

main
