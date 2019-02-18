#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
    echo "updating files that can't be linked"
    rm -rf ./bin
    cp ~/bin ./
    
}

main
