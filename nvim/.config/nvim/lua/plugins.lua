return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

-- colorscheme
use 'Mofiqul/dracula.nvim'
-- status line
use 'hoob3rt/lualine.nvim'
-- git
use 'tpope/vim-fugitive'
use 'mhinz/vim-signify'
use 'f-person/git-blame.nvim'
-- comments made easy
use 'tpope/vim-commentary'
-- completion
use 'neovim/nvim-lspconfig'
use 'glepnir/lspsaga.nvim'
use {
 'nvim-treesitter/nvim-treesitter',
 run = ':TSUpdate'
 }
use 'hrsh7th/nvim-compe'
use 'windwp/nvim-autopairs'
-- formatting
use 'sbdchd/neoformat'
-- file explorer
use 'kyazdani42/nvim-web-devicons' -- for file icons
use 'kyazdani42/nvim-tree.lua' 
-- telescope stuff (order matter I think)
use 'nvim-lua/popup.nvim'
use 'nvim-lua/plenary.nvim'
use 'nvim-telescope/telescope.nvim'
-- whichkey
use 'folke/which-key.nvim'
-- writing
use 'junegunn/goyo.vim'
-- linter
use 'dense-analysis/ale'
end) 
