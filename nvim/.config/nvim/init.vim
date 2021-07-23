call plug#begin('~/.config/nvim/plugged')
" colorscheme
Plug 'Mofiqul/dracula.nvim'
" status line
Plug 'itchyny/lightline.vim'
" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'f-person/git-blame.nvim'
" comments made easy
Plug 'tpope/vim-commentary'
" completion
Plug 'neovim/nvim-lspconfig'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hrsh7th/nvim-compe'
Plug 'windwp/nvim-autopairs'
" prettier
Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['lua']}
" file explorer
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua' 
" telescope stuff (order matter I think)
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" whichkey
Plug 'liuchengxu/vim-which-key'
" writing
Plug 'junegunn/goyo.vim'
" linter
Plug 'dense-analysis/ale'
call plug#end()

set termguicolors

colorscheme dracula

" let g:lightline = { 'colorscheme': 'selenized_black' }
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode' ],  ['relativepath', 'modified' ] ],
      \   'right': [ ['percent'], ['gitbranch'] ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ }
      \ } 
" don't show the mode since it's shown in the statusline
set noshowmode

let mapleader=" "

" show the current line number on the current line and the relative line number on all other lines
set number relativenumber
" default to case insensitive search
set ignorecase 
" break lines between words at window's width
set linebreak
" tabs are 2 spaces wide (but still tabs)
set tabstop=2
set softtabstop=2 
set shiftwidth=2
set expandtab
" hide, don't close buffers when they're not active
set hidden

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

" keep 8 rows of text visible at the top and bottom of screen (if possible)
set scrolloff=8

" move between splits
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-l> :wincmd l<CR>
" make splits easier
nnoremap <silent> <leader>\| <C-w>v
nnoremap <silent> <leader>- <C-w>s

" clipboard
" yank selection to system clipboard
noremap <Leader>y "*y

" git
" git gutter 
set updatetime=10
" git blame 
" off by default
let g:gitblame_enabled = 0
nmap <leader>b :GitBlameToggle<cr>

" which key
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" nvim-tree config
nnoremap <leader>n :NvimTreeToggle <CR>
" show dot files/folders
let g:nvim_tree_hide_dotfiles = 0
let g:nvim_tree_width = '30%'

" telescope config
" Find files using Telescope command-line sugar.
" nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-b> <cmd>Telescope buffers<cr>
nnoremap <C-g> <cmd>Telescope live_grep<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" ALE config
" let g:ale_set_highlights = 1

" LSP config
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
" nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
" nnoremap <silent> <C-m> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" LSP Saga mappings
nnoremap <silent> <leader>d :Lspsaga hover_doc<CR>
nnoremap <silent><leader>ca :Lspsaga code_action<CR>
nnoremap <silent> gs :Lspsaga signature_help<CR>
nnoremap <silent> gr :Lspsaga rename<CR>
" find cursor word definition and references
nnoremap <silent> gh :Lspsaga lsp_finder<CR>
nnoremap <silent> <leader>ca :Lspsaga code_action<CR>
nnoremap <silent> <leader>gd :Lspsaga preview_definition<CR>
nnoremap <silent> <leader>cd :Lspsaga show_line_diagnostics<CR>
nnoremap <silent> [e :Lspsaga diagnostic_jump_next<CR>
nnoremap <silent> ]e :Lspsaga diagnostic_jump_prev<CR>
" scroll down hover doc or scroll in definition preview
" nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" scroll up hover doc
" nnoremap <silent> <C-b> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>

set completeopt=menuone,noselect

lua require('baz')
