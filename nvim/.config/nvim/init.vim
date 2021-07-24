call plug#begin('~/.config/nvim/plugged')
" colorscheme
Plug 'Mofiqul/dracula.nvim'
" status line
Plug 'hoob3rt/lualine.nvim'
" git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
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

" TODO: move this to lua
" map j and k to gj and gk so that they move from visual line to visual line when j or k is
" pressed but move from real line to real line when jumping some number of
" lines across visually wrapped lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

