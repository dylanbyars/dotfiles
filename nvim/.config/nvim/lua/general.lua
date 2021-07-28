--------------------------
-- SETTINGS
--------------------------
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
-- local map = vim.api.nvim_set_keymap
-- local default_opts = {noremap = true}

-- searching
-- map = to a command that searches for the word under the cursor
map('n', '=', '/<C-r><C-w><cr>') -- TODO: I think telescope can do this

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
map('n', '<leader>|', '<C-w>v')
map('n', '<leader>-', '<C-w>s')

-- yank selection to system clipboard
map('n', '<leader>y', '"+y')
map('v', '<leader>y', '"+y')

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
}
vim.g.startify_bookmarks = {
  {v = '~/dotfiles/nvim/.config/nvim/lua/general.lua'},
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
local function t(builtin, options) 
  args = builtin..(options == nil and '()' or '('..options..')')
  return "<cmd>lua require('telescope.builtin')."..args..'<cr>'
end

-- find all files (including hidden) but NOT any files in the hidden `.git/` directory
map('n', '<C-p>', t('find_files', "{ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }}"))
map('n', '<C-b>', t('buffers'))
map('n', '<C-g>', t('live_grep'))
map('n', '<leader>/', '/')
map('n', '/', t('current_buffer_fuzzy_find')) -- 
map('n', '<leader>?', t('help_tags')) -- for quick vim `help`
map('n', '<leader>man', t('man_pages')) -- search for a man page, preview it, and open it in a vim buffer on <cr>
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
-- close tree AND remove highlights when <esc> is pressed
map('n', '<esc>', '<cmd>:NvimTreeClose<cr><cmd>:noh<cr>')
-- vim.g.nvim_tree_follow = 1 -- TODO: this shows the whole file system, not just the vcs root's folder
vim.g.nvim_tree_hide_dotfiles = 0
vim.g.nvim_tree_width = '25%'


--------------------------
-- git
--------------------------
require('gitsigns').setup()

--------------------------
-- neoformat
--------------------------
-- π = <Option-p>
map('n', 'π', '<cmd>:Neoformat prettier<cr>')


--------------------------
-- treesitter
--------------------------
require'nvim-treesitter.configs'.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = { 'javascript', 'bash', 'css', 'html', 'jsdoc', 'json', 'lua', 'regex', 'scss', 'tsx', 'typescript', 'yaml', 'toml' }, 
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
    colors = { -- table of hex strings
      '#f7768e',
      '#9ece6a',
      '#e0af68',
      '#7aa2f7',
      '#bb9af7',
      '#7dcfff',
      '#a9b1d6'
    }, 
  },
  -- refactor = {
  --   highlight_current_scope = { enable = true },
  --   highlight_definitions = { enable = true },
  -- },
}

require'treesitter-context.config'.setup{ enable = true }



--------------------------
-- LSP config
--------------------------
local function organize_imports()
  vim.lsp.buf.execute_command({
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
  })
end

require'lspconfig'.tsserver.setup {
    commands = {
      OrganizeImports = {
        organize_imports,
        description = "Organize Imports"
      }
  }
}
-- ø = <Option-o>
map('n', 'ø', '<cmd>:OrganizeImports<cr>')

require'lspconfig'.bashls.setup{}
require'lspconfig'.vimls.setup{}


--------------------------
-- LSP saga config
--------------------------
local saga = require 'lspsaga'
saga.init_lsp_saga {
  use_saga_diagnostic_sign = false,
  border_style = 'round',
  max_preview_lines = 15,
  finder_action_keys = {
    open = 'o', 
    vsplit = 's', 
    split = 'i', 
    quit = 'q',
    scroll_down = '<C-,>', 
    scroll_up = '<C-.>' 
  }
}

map('n', '<leader>d', '<cmd>:Lspsaga hover_doc<CR>')
map('n', 'gr', '<cmd>:Lspsaga rename<CR>')
-- find cursor word definition and references
map('n', 'gh', '<cmd>:Lspsaga lsp_finder<CR>')
map('n', '<leader>gd', '<cmd>:Lspsaga preview_definition<CR>')
-- Lsp navigation
-- go to definition
-- TODO: there are a lot more built in functions on the `vim.lsp.buf` object
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')


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
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    -- spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true; 
  };
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

