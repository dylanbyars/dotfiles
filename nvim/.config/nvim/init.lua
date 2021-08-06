--------------------------
-- PLUGINS
--------------------------
require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- colorscheme
  use 'folke/tokyonight.nvim'
  -- start page
  use 'mhinz/vim-startify'
  -- status line
  use 'hoob3rt/lualine.nvim'
  -- git
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
  -- comments made easy
  use 'tpope/vim-commentary'
  -- completion
  use 'neovim/nvim-lspconfig'
  use 'kabouzeid/nvim-lspinstall' -- for installing language servers
  use 'glepnir/lspsaga.nvim'
  use 'hrsh7th/nvim-compe'
  use 'ray-x/lsp_signature.nvim'
  use 'windwp/nvim-autopairs'
  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'windwp/nvim-ts-autotag'
  -- use 'nvim-treesitter/nvim-treesitter-textobjects' -- like ^ but you define specific text objects. TODO: learn about it.
  use 'nvim-treesitter/nvim-treesitter-refactor' -- for scope and symbol highlights
  use 'romgrk/nvim-treesitter-context'
  use 'p00f/nvim-ts-rainbow' -- prettier () [] {}
  -- formatting
  use 'sbdchd/neoformat'
  -- search improvements
  use 'kevinhwang91/nvim-bqf' -- prettier quickfix lists
  use 'wincent/loupe'
  -- file explorer
  use 'kyazdani42/nvim-web-devicons' -- for file icons
  use 'kyazdani42/nvim-tree.lua'
  -- telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- writing
  use 'junegunn/goyo.vim'
end)


--------------------------
-- SETTINGS
--------------------------

local colors = {
  background = '#1a1b26',
  foreground = '#c0caf5',
  black =   '#15161E',
  red =     '#f7768e',
  green =   '#9ece6a',
  yellow =  '#e0af68',
  blue =    '#7aa2f7',
  magenta = '#bb9af7',
  cyan =    '#7dcfff',
  white =   '#a9b1d6',
}

vim.o.termguicolors = true
vim.g.tokyonight_style = 'night'
vim.cmd[[colorscheme tokyonight]]
-- change the color of the line between vertical splits
-- vim.cmd[[highlight VertSplit guifg=#7dcfff]]-- not working...

-- make the mouse work
vim.o.mouse = 'a'

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- don't show mode since it's in the statusline
vim.o.showmode = false

-- always show the sign column
vim.o.signcolumn = 'yes'
-- do not show the fold column (too busy)
vim.o.foldcolumn = "0"
-- start file completely unfolded
vim.o.foldlevelstart = 99
-- use treesitter to define foldable areas
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

-- show the current line number on the current line and the relative line number on all other lines
vim.o.number = true
vim.o.relativenumber = true

-- don't require a file save before switching buffers
vim.o.hidden = true

-- default to case insensitive search
vim.o.ignorecase = true
-- break lines between words at window's width
vim.o.linebreak = true
-- tabs are 2 spaces wide
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- keep 8 rows of text visible at the top and bottom of screen (if possible)
vim.o.scrolloff = 8

-- put new splits below or to the right
vim.o.splitbelow = true
vim.o.splitright = true

--------------------------
-- general key bindings
--------------------------

local function map(mode, mapping, action, options)
  options = options == nil and {noremap = true} or options
  return vim.api.nvim_set_keymap(mode, mapping, action, options)
end

map('n', '<leader>w', '<cmd>:w<cr>')
map('n', '<leader>q', '<cmd>:q<cr>')
map('n', '<leader>;', ':')
map('v', '<leader>;', ':')

-- toggle fold
map('n', '<S-Tab>', 'za')

-- move down/up 10 lines with capital J/K
map('n', 'J', '10j')
map('v', 'J', '10j')
map('n', 'K', '10k')
map('v', 'K', '10k')

-- map j and k to gj and gk so that they move from visual line to visual line when j or k is
-- pressed but move from real line to real line when jumping some number of
-- lines across visually wrapped lines
-- TODO: convert to lua
vim.api.nvim_exec("nnoremap <expr> j v:count ? 'j' : 'gj'", false)
vim.api.nvim_exec("nnoremap <expr> k v:count ? 'k' : 'gk'", false)

-- move between splits with arrow keys
map('n', '<left>', ':wincmd h<cr>')
map('n', '<down>', ':wincmd j<cr>')
map('n', '<up>', ':wincmd k<cr>')
map('n', '<right>', ':wincmd l<cr>')
-- make splits easier
map('n', '<leader>\\', '<C-w>v')
map('n', '<leader>-', '<C-w>s')

-- yank selection to system clipboard
map('n', '<leader>y', '"+y')
map('v', '<leader>y', '"+y')
-- make Y behave like other capital letter commands
map('n', 'Y', 'y$')

--------------------------
-- plugin configs
--------------------------


--------------------------
-- startify
--------------------------
vim.g.startify_change_to_vcs_root = 1
vim.g.startify_custom_header = 'startify#center(startify#fortune#cowsay())'
vim.g.startify_lists = {
  {type = 'bookmarks', header = {' Projects'}},
  {type = 'files', header = {' Recent Files'}},
  {type = 'sessions', header = {' Sessions'}}
}
vim.g.startify_bookmarks = {
  {v = '~/dotfiles/nvim/.config/nvim/init.lua'},
  {z = '~/dotfiles/zsh/.zshrc'},
  {t = '~/dotfiles/tmux/.tmux.conf'},
  {d = '~/dotfiles'},
  {a = '~/code/api'},
  {c = '~/code/client'},
  {g = '~/code/gravity-components'},
  '~/code'
}


--------------------------
-- telescope
--------------------------
local function telescope(builtin, options)
  local args = builtin..(options == nil and '()' or '('..options..')')
  return "<cmd>lua require('telescope.builtin')."..args..'<cr>'
end

-- find all files (including hidden) but NOT any files in the hidden `.git/` directory
map('n', '<leader>p', telescope('find_files', "{ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }}"))
map('n', '<leader>b', telescope('buffers'))
map('n', '<leader>g', telescope('live_grep'))
map('n', '<leader>/', telescope('current_buffer_fuzzy_find')) --
map('n', '<leader><esc>', telescope('help_tags')) -- for quick vim `help`
map('n', '<leader>man', telescope('man_pages')) -- search for a man page, preview it, and open it in a vim buffer on <cr>
-- map('n', '=', t('grep_string')) -- not working and I don't know why
-- TODO:
-- builtin.oldfiles
-- builtin.search_history
-- builtin.marks
-- builtin.registers
-- builtin.spell_suggest
-- builtin.lsp_FOO lots here...

require('telescope').setup {
  extensions = {
    -- faster live_grep. I think. Should probably verify that...
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- "smart_case" (default) or "ignore_case" or "respect_case"
    }
  }
}
require('telescope').load_extension('fzf')

--------------------------
-- nvim-tree
--------------------------
map('n', '<leader><leader>', '<cmd>:NvimTreeFindFile<cr>')
-- TODO: switch focus back to the previous pane. currently focus moves to the pane closest to the tree
map('n', '<esc>', '<cmd>:NvimTreeClose<cr>')
-- vim.g.nvim_tree_follow = 1 -- TODO: this shows the whole file system, not just the vcs root's folder
vim.g.nvim_tree_highlight_opened_files = 3
vim.g.nvim_tree_hide_dotfiles = 0
vim.g.nvim_tree_width = '25%'

--------------------------
-- git
--------------------------
require('gitsigns').setup()

--------------------------
-- neoformat
--------------------------
map('n', '<leader>f', '<cmd>:Neoformat prettier<cr>')


--------------------------
-- treesitter
--------------------------
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
  }
  -- refactor = {
    --   highlight_current_scope = { enable = true },
    --   highlight_definitions = { enable = true },
    -- },
  }

  require'treesitter-context.config'.setup{ enable = true }



  --------------------------
  -- LSP config
  --------------------------
  -- TODO: there's gotta be a better way to record what servers a person's installed...
  -- servers installed:
  -- typescript
  -- html
  -- css
  -- lua
  -- dockerfile
  -- bash
  -- yaml
  -- vim
  local function setup_servers()
    require'lspinstall'.setup()
    local servers = require'lspinstall'.installed_servers()
    for _, server in pairs(servers) do
      local config = {}

      if server == 'typescript' then

        local function organize_imports()
          vim.lsp.buf.execute_command({
            command = "_typescript.organizeImports",
            arguments = {vim.api.nvim_buf_get_name(0)},
          })
        end

        config = {
          commands = {
            OrganizeImports = {
              organize_imports,
              description = "Organize Imports"
            }
          }
        }
      end

      -- make lua language server aware of a global variable called `vim`
      if server == 'lua' then
        config = {
          settings = {
            Lua = {
              diagnostics = {
                globals = { 'vim' }
              }
            }
          }
        }
      end

      require'lspconfig'[server].setup(config)
    end
  end

  setup_servers()

  -- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
  require'lspinstall'.post_install_hook = function ()
    setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
  end


  map('n', '<leader>o', '<cmd>:OrganizeImports<cr>')


  --------------------------
  -- LSP saga config
  --------------------------
  local saga = require 'lspsaga'
  saga.init_lsp_saga {
    use_saga_diagnostic_sign = false,
    border_style = 'round',
    max_preview_lines = 15,
  }

  map('n', '<leader>d', '<cmd>:Lspsaga hover_doc<CR>')
  map('n', '<leader>gd', '<cmd>:Lspsaga preview_definition<CR>')
  -- diagnostics
  map('n', '<leader>ld', '<cmd>:Lspsaga show_line_diagnostics<CR>')
  map('n', '[e', '<cmd>:Lspsaga diagnostic_jump_prev<CR>')
  map('n', ']e', '<cmd>:Lspsaga diagnostic_jump_next<CR>')



  -- additional lsp mappings using regular lsp api
  map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  map('v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>')
  map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  -- rename symbol under cursor and set the rename in the command line window
  map('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR><c-F>')
  -- view references in the quickfix list
  map('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  -- view all diagnostics in the file in the quickfix list
  map('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.set_qflist()<CR>')


  --------------------------
  -- completion helpers
  --------------------------
  require('nvim-autopairs').setup()

  require('lsp_signature').setup({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    doc_lines = 2, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
    -- set to 0 if you DO NOT want any API comments be shown
    -- This setting only take effect in insert mode, it does not affect signature help in normal
    -- mode, 10 by default
    hint_enable = false, -- virtual hint enable
    floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
    fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
    -- use_lspsaga = false,  -- set to true if you want to use lspsaga popup
    hi_parameter = "Search", -- how your parameter will be highlight
    max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
    -- to view the hiding contents
    max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
    handler_opts = {
      border = "single"   -- double, single, shadow, none
    },
  })

  --------------------------
  -- Compe setup
  --------------------------
  vim.o.completeopt = 'menuone,noselect'

  require'compe'.setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = true,

    source = {
      path = true,
      buffer = true,
      calc = true,
      vsnip = true,
      nvim_lsp = true,
      nvim_lua = true,
      -- spell = true,
      tags = true,
      snippets_nvim = true,
      treesitter = true,
    },
  }

  local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
      return true
    else
      return false
    end
  end

  -- Use (s-)tab to:
  --- move to prev/next item in completion menuone
  --- jump to prev/next snippet's placeholder
  _G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t '<C-n>'
    elseif check_back_space() then
      return t '<Tab>'
    else
      return vim.fn['compe#complete']()
    end
  end
  _G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t '<C-p>'
    else
      return t '<S-Tab>'
    end
  end

  vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
  vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', {expr = true})
  vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
  vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
  -- Map compe confirm and complete functions
  vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
  vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })


  require'lualine'.setup {
    options = {
      icons_enabled = true,
      theme = 'tokyonight',
      component_separators = {'', ''},
      section_separators = {'', ''},
      disabled_filetypes = {}
    },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {
        {'filename', path = 1} -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
      lualine_c = {
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
      lualine_x = {
        -- TODO:
        -- 'diagnostics',
        --   sources = {'nvim_lsp'},
        --   -- displays diagnostics from defined severity
        --   sections = {'error', 'warn', 'info', 'hint'},
        --   -- all colors are in format #rrggbb
        --   color_error = nil, -- changes diagnostic's error foreground color
        --   color_warn = nil, -- changes diagnostic's warn foreground color
        --   color_info = nil, -- Changes diagnostic's info foreground color
        --   color_hint = nil, -- Changes diagnostic's hint foreground color
        --   symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'}
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
