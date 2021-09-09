-- Install packer
local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd [[packadd packer.nvim]] -- see this line in a lot of setup packer automatically snippets. why?
require('packer').startup({function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- colorscheme
  use 'folke/tokyonight.nvim'
  use 'norcalli/nvim-colorizer.lua'
  -- start page
  use 'mhinz/vim-startify'
  -- status line
  use 'hoob3rt/lualine.nvim'
  use { "SmiteshP/nvim-gps", requires = "nvim-treesitter/nvim-treesitter" }
  -- git
  use 'tpope/vim-fugitive'
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- comment helpers
  use 'tpope/vim-commentary' -- comments made easy
  use 'JoosepAlviste/nvim-ts-context-commentstring' -- comment bits out with proper style based on their location determined by treesitter i.e. js vs jsx
  -- completion
  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall' -- for installing language servers
  use { 'hrsh7th/vim-vsnip', requires = { 'hrsh7th/vim-vsnip-integ' } }
  use "rafamadriz/friendly-snippets"
  use 'glepnir/lspsaga.nvim'
  use 'hrsh7th/nvim-compe'
  use 'ray-x/lsp_signature.nvim'
  use 'windwp/nvim-autopairs'
  use 'RRethy/vim-illuminate'
  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {'nvim-treesitter/playground', run = ':TSInstall query'}
  use 'windwp/nvim-ts-autotag'
  -- use 'nvim-treesitter/nvim-treesitter-textobjects' -- like ^ but you define specific text objects. TODO: learn about it.
  use 'nvim-treesitter/nvim-treesitter-refactor' -- for scope and symbol highlights
  use 'romgrk/nvim-treesitter-context'
  use 'p00f/nvim-ts-rainbow' -- prettier () [] {}
  -- formatting
  use 'sbdchd/neoformat'
  -- search improvements
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use 'wincent/loupe' -- search highlight improved
  use {
    'phaazon/hop.nvim',
    as = 'hop',
    config = function()
      require("hop").setup()
    end
  }
  -- file explorer
  use 'kyazdani42/nvim-web-devicons' -- for file icons
  use 'kyazdani42/nvim-tree.lua'
  -- telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
      {
        'AckslD/nvim-neoclip.lua',
        config = function()
          require('neoclip').setup({
            -- TODO: want to configure the display but not sure how...
          })
        end
      }
    }
  }
  -- idk
  use 'tpope/vim-unimpaired'
  use 'wfxr/minimap.vim'
  use 'voldikss/vim-floaterm'
  -- writing
  use 'junegunn/goyo.vim'
end,
config = {
  -- show packer outputs in a floating window
  display = {
    open_fn = function()
      return require('packer.util').float({border = 'single'})
    end,
  }
}})

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]], false)

require('plugins.treesitter')

require('colorizer').setup()

require('gitsigns').setup()

require('nvim-autopairs').setup()

require('plugins.telescope')

require('plugins.lsp')

require('plugins.compe')

require('plugins.lualine')
