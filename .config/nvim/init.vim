call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/vim-easy-align' 
Plug 'sheerun/vim-polyglot' 
Plug 'HerringtonDarkholme/yats.vim' 
Plug 'tpope/vim-surround'
"Plug 'mhartington/nvim-typescript' 
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree' 
Plug 'scrooloose/nerdcommenter' 
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'neovimhaskell/haskell-vim'
Plug 'purescript-contrib/purescript-vim'
Plug 'ctrlpvim/ctrlp.vim' 
Plug 'vim-scripts/ReplaceWithRegister'
call plug#end()

set updatetime=100


" toggle comment with <leader>c<space> - from nerdcommenter
:map // <plug>NERDCommenterToggle

packadd vimball
" provide access to x clipboard
:set clipboard+=unnamedplus
:vnoremap <C-C> "+y
:map <C-V> "+P

" inject whitespace
:nmap <C-Space> i<space><Esc>l
:nmap <C-N> A<CR><Esc>
:nmap <A-C-n> i<C R><Esc>

" auto close quotes and parens
":inoremap ` ``<left>
":inoremap " ""<left>
":inoremap ' ''<left>
":inoremap ( ()<left>
":inoremap [ []<left>
":inoremap { {}<left>

" clear search highligting
:map <C-H> :nohls<Enter>


map <C-l> :call g:ToggleNuMode()<CR>

"edit and refresh vimrc
:command Vimrc :e $MYVIMRC<Enter>
:command Refresh :so $MYVIMRC

":set nu rnu
:set autoread
:set autoindent
:set smartindent
:syntax on
:set nocp
:set number relativenumber
:set list
:set listchars+=tab:▶·,eol:↲
:set listchars+=space:·
:set listchars+=trail:·
:set hls  
:filetype plugin indent on
:set wildmenu
:set scrolloff=5
:set ignorecase
:set smartcase

:set lbr


:nmap <leader>n :NERDTree<Enter>
:nmap <leader>h :nohls<Enter>

" On pressing tab, insert 2 spaces
:set expandtab
" show existing tab with 2 spaces width
:set tabstop=2
:set softtabstop=2
" when indenting with '>', use 2 spaces width
:set shiftwidth=2

