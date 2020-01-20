call plug#begin('~/.local/share/nvim/plugged')
Plug 'junegunn/vim-easy-align' 
Plug 'sheerun/vim-polyglot' 
" Plug 'HerringtonDarkholme/yats.vim' 
Plug 'tpope/vim-surround'
"Plug 'mhartington/nvim-typescript' 
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'maxmellon/vim-jsx-pretty'
" Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdtree' 
Plug 'scrooloose/nerdcommenter' 
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'neovimhaskell/haskell-vim'
Plug 'purescript-contrib/purescript-vim'
call plug#end()

set updatetime=100

" toggle comment with // in normal mode
let g:NERDSpaceDelims = 1
:map // <plug>NERDCommenterToggle

packadd vimball

" provide access to x clipboard
:set clipboard+=unnamedplus
" Ctrl+shift+C copies to main clipboard in visual mode
:vnoremap <C-c> "+y
:vnoremap <C-d> "+d
" Ctrl+shift+v pastes from main clipboard in insert mode, allowing the same
" command to enter visual block mode in normal mode
:inoremap <C-v> <Esc>"+Pa

" inject a space immediately before selected char from normal mode
:nmap <C-Space> i<space><Esc>l
" inject a newline immediately after current line
:nmap <C-n> A<CR><Esc>
" inject a newline immediately before selected char
:nmap <A-C-n> i<CR><Esc>
" inject a newline on the line above the current line
:nmap <A-C-N> O<ESC><DOWN>

" spam a macro with Ctrl+.
:nmap <C-.> @@

" inject haskell pragma syntax
:nmap <leader>l i{-# LANGUAGE  #-}<Esc><<o<Esc>k$4ha


"edit and refresh vimrc
:command Vimrc :e $MYVIMRC<Enter>
:command Refresh :so $MYVIMRC

" be lazy with the shift key when writing a file or quitting
:command W :w
:command Q :q

" checks for file changes  and updates the buffer
:set autoread

" enable syntax if possible
if has ('syntax') && !exists('g:syntax_on')
  syntax enable
endif

"allow backspace over anything in normal mode
set backspace=indent,eol,start

" turns off annoying compatibility mode with v/vi
:set nocp

" turns on line numbers
" use :RN to show both relative line numbers and concrete at the same time
:set number

" controls whitespace rendering
:set list
:set listchars+=tab:▶·,eol:↲
:set listchars+=space:·
:set listchars+=trail:·
:set listchars+=extends:>
:set listchars+=precedes:<
:set listchars+=nbsp:+

" allow search highlighting
:set hls  
" clear search highligting
:map <C-H> :nohls<Enter>
" control case-sensitivity when searching
:set ignorecase

:set smartcase

" show menu options as you write commands
:set wildmenu

" sets the maximum rows between cursor and screen bottom when moving
:set scrolloff=15

" controls line-breaking and word-wrapping
:set wrap
:set lbr


" Nerdtree default size and hotkey
:let g:NERDTreeWinSize=20
:nmap <leader>n :NERDTree<Enter>

" indentation behaviour 
:filetype plugin indent on
:set autoindent
" On pressing tab, insert 2 spaces
:set expandtab
" show existing tab with 2 spaces width
:set tabstop=2
:set softtabstop=2
" when indenting with '>', use 2 spaces width
:set shiftwidth=2

" auto-reload files when they change
au FocusGained,BufEnter * :silent! checktime
" while the below command is recommended for auto-reloading, it causes issues
" with pscid/ghcid/nodemon
" au FocusLost,WinLeave * :silent! w

" control key timeout to avoid delays exiting insert mode
if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

" always show status
set laststatus=2

" show when a column exceeds 80 char
:set colorcolumn=80
:set ruler

" utf8 encode
if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

" enables session memory
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options
set viewoptions-=options
