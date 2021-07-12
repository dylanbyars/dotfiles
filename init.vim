call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-commentary'
Plug 'neovim/nvim-lspconfig'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
call plug#end()

" something's weird with my statusline config. Just shows a big empty white
" box
set laststatus=1
hi statusline gui=NONE

set termguicolors

" show the current line number on the current line and the relative line number on all other lines
set number relativenumber
" default to case insensitive search
set ignorecase 
" break lines between words at window's width
set linebreak
" tabs are 2 spaces wide (but still tabs)
set tabstop=2

" map j and k to gj and gk so that they move from visual line to visual line when j or k is
" pressed but move from real line to real line when jumping some number of
" lines across visually wrapped lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" map = to a command that searches for the word under the cursor
nmap = /<C-r><C-w>

" move down/up 10 lines with capital J/K
noremap <silent> J 10j
noremap <silent> K 10k

" always keep cursor in the center of the screen (except for at the top or bottom of a file)
set scrolloff=999
set sidescrolloff=999


