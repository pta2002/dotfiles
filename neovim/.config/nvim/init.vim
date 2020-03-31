" Plugins
call plug#begin(stdpath('data') . '/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'ntk148v/vim-horizon'
Plug 'tpope/vim-commentary'
Plug 'neovimhaskell/haskell-vim'
Plug 'tpope/vim-sensible'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'godlygeek/tabular'

call plug#end()

let g:airline_powerline_fonts = 1

" Set leader key
let mapleader = ","

" Quickly edit/reload the vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Color theme
set termguicolors
colorscheme horizon

" Ensure the background is transparent
hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE

let g:airline_theme='bubblegum'

" Show numbers
set number

" Set indentation
set tabstop=4
set expandtab " use spaces instead of tab
set shiftwidth=4 " Indent using 4 spaces
set autoindent smartindent cindent
filetype plugin indent on
