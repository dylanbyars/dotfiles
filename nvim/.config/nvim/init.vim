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
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
" file explorer
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua' 
" telescope stuff (order matter I think)
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" whichkey
Plug 'folke/which-key.nvim'
" writing
Plug 'junegunn/goyo.vim'
" linter
Plug 'dense-analysis/ale'
call plug#end()

lua require('baz')

let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode' ],  ['relativepath', 'modified' ] ],
      \   'right': [ ['percent'], ['gitbranch'] ],
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ }
      \ } 


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


" ALE config
" let g:ale_set_highlights = 1

" is this for lsp saga?
set completeopt=menuone,noselect

