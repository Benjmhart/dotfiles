if [[ ! -d ~\AppData\Local\nvim ]] 
then 
  mkdir ~\AppData\Local\nvim
fi

cp ~/dotfiles/.configure/nvim/init.vim ..\Appdata\Local\nvim\init.vim
