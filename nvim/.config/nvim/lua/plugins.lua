return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- colorscheme
  use 'Mofiqul/dracula.nvim'
  -- start page
  use 'mhinz/vim-startify'
  -- status line
  use 'hoob3rt/lualine.nvim'
  -- git
  use 'mhinz/vim-signify'
  use 'f-person/git-blame.nvim'
  -- comments made easy
  use 'tpope/vim-commentary'
  -- completion
  use 'neovim/nvim-lspconfig'
  use 'glepnir/lspsaga.nvim'
  use 'hrsh7th/nvim-compe'
  use 'ray-x/lsp_signature.nvim'
  use 'windwp/nvim-autopairs'
  -- treesitter
  use {
   'nvim-treesitter/nvim-treesitter',
   run = ':TSUpdate'
  }
  use 'nvim-treesitter/nvim-treesitter-refactor' -- for scope and symbol highlights
  use 'romgrk/nvim-treesitter-context'
  use 'p00f/nvim-ts-rainbow' -- prettier () [] {}
  -- formatting
  use 'sbdchd/neoformat'
  -- file explorer
  use 'kyazdani42/nvim-web-devicons' -- for file icons
  use 'kyazdani42/nvim-tree.lua' 
  -- telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  -- whichkey
  use 'folke/which-key.nvim'
  -- writing
  use 'junegunn/goyo.vim'
  -- linter
  use 'dense-analysis/ale'
end) 
