-- Install packer
local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
end

vim.cmd [[packadd packer.nvim]] -- see this line in a lot of setup packer automatically snippets. why?
require('packer').startup({function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself
  -- colors
  use 'folke/tokyonight.nvim' -- colorscheme
  use 'norcalli/nvim-colorizer.lua' -- highlight hex strings with their color
  use 'mhinz/vim-startify' -- session manager and fancy start screen
  -- status line
  use 'hoob3rt/lualine.nvim'
  use { "SmiteshP/nvim-gps", requires = "nvim-treesitter/nvim-treesitter" }
  -- git
  use 'tpope/vim-fugitive' -- ya it's pretty good
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- git info in the signs column + status line
  -- comment helpers
  use 'tpope/vim-commentary' -- comments made easy
  use 'JoosepAlviste/nvim-ts-context-commentstring' -- comment bits out with proper style based on their location determined by treesitter i.e. js vs jsx
  -- completion
  use 'neovim/nvim-lspconfig' -- configure lsp
  use 'kabouzeid/nvim-lspinstall' -- for installing language servers
  use 'L3MON4D3/LuaSnip' -- cmp requires a snippet engine
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      -- completion sources
      'saadparwaiz1/cmp_luasnip',
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-calc",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-nvim-lsp"
    },
  }
  use 'windwp/nvim-autopairs' -- finsh the starting tag/symbol/thing
  use 'RRethy/vim-illuminate' -- highlight other instances of the focused word
  -- treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {'nvim-treesitter/playground', run = ':TSInstall query'}
  use 'windwp/nvim-ts-autotag' -- auto close and auto update closing tags
  use 'nvim-treesitter/nvim-treesitter-refactor' -- for scope and symbol highlights
  use 'p00f/nvim-ts-rainbow' -- prettier () [] {}
  -- formatting
  use 'sbdchd/neoformat'
  -- search improvements
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function() require("trouble").setup{} end
  }
  use 'wincent/loupe' -- search highlight improved
  -- telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    }
  }
  -- idk
  use 'tpope/vim-surround'
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

require('plugins.telescope')

require('plugins.lsp')

require('plugins.cmp')

-- nvim-autopairs stuff has to go after cmp setup
require('nvim-autopairs').setup{}

require("nvim-autopairs.completion.cmp").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = true -- automatically select the first item
})

require('plugins.lualine')

require('plugins.startify')
