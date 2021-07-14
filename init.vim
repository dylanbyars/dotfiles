call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'neovim/nvim-lspconfig'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
" telescope stuff
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
"
call plug#end()

let mapleader = " "

set termguicolors

" statusline
" left side
set statusline=
set statusline+=\ %f			" show relative path to current file
" right side
set statusline+=%=
set statusline+=\ ·\ 		" interpunct
set statusline+=%{FugitiveHead()} " show current branch 
set statusline+=\ ·\ 		" interpunct

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

" move between splits
nmap <silent> <leader>k :wincmd k<CR>
nmap <silent> <leader>j :wincmd j<CR>
nmap <silent> <leader>h :wincmd h<CR>
nmap <silent> <leader>l :wincmd l<CR>

" telescope config
" Find files using Telescope command-line sugar.
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-b> <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

