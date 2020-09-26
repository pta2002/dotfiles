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

let g:airline_theme='bubblegum'

" Show numbers
set number

" Set indentation
set tabstop=4
set expandtab " use spaces instead of tab
set shiftwidth=4 " Indent using 4 spaces
set autoindent smartindent cindent
filetype plugin indent on

" LSP things!
" Use clangd for C smarts
autocmd Filetype c setlocal omnifunc=v:lua.vim.lsp.omnifunc

lua <<EOF
require('nvim_lsp').clangd.setup{}
EOF

autocmd CompleteDone * pclose

nnoremap <leader>ld :lua vim.lsp.buf.declaration()<CR>
nnoremap <leader>lf :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>ff :lua vim.lsp.buf.formatting()<CR>

" Treesitter things!
lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
        enable = true,
    },
}
EOF
