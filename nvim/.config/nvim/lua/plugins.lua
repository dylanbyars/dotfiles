local colors = require('colors')

-- plugin repos cloned to ~/.local/share/nvim/site/pack/packer/start/
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

require'nvim-treesitter.configs'.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
    'bash',
    'comment', -- highlight TODO and FIXME comments
    'css',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'lua',
    'regex',
    'scss',
    'toml',
    'tsx',
    'typescript',
    'yaml',
  },
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
    colors = function ()
      local c = {}
      for key, value in pairs(colors) do
        if key ~= 'foreground' and key ~= 'background' then
          table.insert(c, value)
        end
      end
      return c
    end
  },
  autotag = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      node_incremental = "o", -- out
      scope_incremental = "O", -- OUT!
      node_decremental = "i", -- in
    }
  },
  context_commentstring = { enable = true }
}

require'treesitter-context.config'.setup{ enable = true }

local gps = require("nvim-gps")
gps.setup()

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {'minimap'}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      {'filename', path = 1} -- 0 = just filename, 1 = relative path, 2 = absolute path
    },
    lualine_c = {
      { gps.get_location, condition = gps.is_available },
    },
    lualine_x = {
      {
        'diff',
        colored = true, -- displays diff status in color if set to true
        -- all colors are in format #rrggbb
        color_added = colors.green, -- changes diff's added foreground color
        color_modified = colors.yellow, -- changes diff's modified foreground color
        color_removed = colors.red, -- changes diff's removed foreground color
        symbols = {added = '+', modified = '~', removed = '-'} -- changes diff symbols
      }
    },
    lualine_y = {'branch'},
    lualine_z = {'progress'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

require('colorizer').setup()

