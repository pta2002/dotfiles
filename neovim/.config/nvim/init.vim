" Plugins
call plug#begin(stdpath('data') . '/plugged')

" Helpful things
Plug 'tpope/vim-surround'              " Easily surround things in quotes, parentheses, etc.
Plug 'tpope/vim-commentary'            " Easily comment/uncomment things with gcc
Plug 'tpope/vim-sensible'              " Some sensible defaults
Plug 'godlygeek/tabular'               " Easily align things with :Tabularize

" Theming
Plug 'vim-airline/vim-airline'         " Nice looking status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'ntk148v/vim-horizon'

" Languages
Plug 'dag/vim-fish'                    " Fish scripting
Plug 'neovimhaskell/haskell-vim'       " Haskell

" IDE things
Plug 'neovim/nvim-lspconfig'           " Requires v0.5
Plug 'nvim-treesitter/nvim-treesitter' " Requires v0.5
Plug 'tpope/vim-fugitive'              " Git integration
Plug 'nvim-lua/completion-nvim'        " Autocomplete based on LSP

call plug#end()

let g:airline_powerline_fonts = 1

" Set leader key
let mapleader = ","

" Stop requiring shift for common actions! Search and : are now just one
" keystroke away
map ç :
map - /

" Quickly edit/reload the vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" Color theme
set termguicolors
colorscheme horizon
let g:airline_theme='bubblegum'

" Enable the mouse
set mouse=a

" Use system clipboard by prefixing copy/paste commands with leader
nnoremap <leader>y "+y
nnoremap <leader>p "+p

" Ensure the background is transparent
hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE
hi EndOfBuffer guibg=NONE ctermbg=NONE
hi LineNr guibg=NONE ctermbg=NONE

" Show numbers
set number

" Set indentation
set tabstop=4
set expandtab " use spaces instead of tab
set shiftwidth=4 " Indent using 4 spaces
set autoindent smartindent cindent
filetype plugin indent on

" Tab complete case insensitive
set wildignorecase

" Load Lua init file
lua <<EOF
require 'init'
EOF

" LSP things!
autocmd Filetype c setlocal omnifunc=v:lua.vim.lsp.omnifunc
autocmd Filetype cpp setlocal omnifunc=v:lua.vim.lsp.omnifunc

autocmd CompleteDone * pclose

nnoremap <leader>ld :lua vim.lsp.buf.declaration()<CR>
nnoremap <leader>lf :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>ff :lua vim.lsp.buf.formatting()<CR>

" Use Tab and S-Tab to navigate
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

imap <silent> <c-Space> <Plug>(completion_trigger)

" Only trigger autocomplete if it's longer than 3 characters
let g:completion_trigger_keyword_length = 3

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c
