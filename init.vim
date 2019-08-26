call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/vim-easy-align' 
Plug 'sheerun/vim-polyglot' 
Plug 'Shougo/deoplete.nvim' 
Plug 'HerringtonDarkholme/yats.vim' 
Plug 'mhartington/nvim-typescript' 
Plug 'scrooloose/nerdtree' 
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'neovimhaskell/haskell-vim'
Plug 'purescript-contrib/purescript-vim'

let g:deoplete#enable_at_startup = 1

:set autoindent
:set smartindent
:syntax on
:set nocp
:set number
:set listchars=tab:>-,trail:·
:set list
:filetype plugin indent on
" On pressing tab, insert 2 spaces
:set expandtab
" show existing tab with 2 spaces width
:set tabstop=2
:set softtabstop=2
" when indenting with '>', use 2 spaces width
:set shiftwidth=2

" wishlist:
" 1. indent/unindent on ctrl-bracket
" 2. comment/uncomment on ctrl /
