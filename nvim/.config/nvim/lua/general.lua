--------------------------
-- SETTINGS
--------------------------
vim.o.termguicolors = true
vim.g.tokyonight_style = 'night'
vim.cmd[[colorscheme tokyonight]]

-- make the mouse work
vim.o.mouse = 'a'

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- persistent undo
-- vim.o.undofile = true

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

-- shorten timeout before whichkey menu appears
vim.o.timeoutlen = 500

-- keep 8 rows of text visible at the top and bottom of screen (if possible)
vim.o.scrolloff = 8

-- put new splits below or to the right
vim.o.splitbelow = true
vim.o.splitright = true

--------------------------
-- general key bindings
--------------------------

local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true}

-- searching
-- map = to a command that searches for the word under the cursor
map('n', '=', '/<C-r><C-w><cr>', default_opts)
map('n', '<esc>', '<cmd>:noh<cr>', default_opts)

-- move down/up 10 lines with capital J/K
map('n', 'J', '10j', default_opts)
map('v', 'J', '10j', default_opts)
map('n', 'K', '10k', default_opts)
map('v', 'K', '10k', default_opts)

-- map j and k to gj and gk so that they move from visual line to visual line when j or k is
-- pressed but move from real line to real line when jumping some number of
-- lines across visually wrapped lines
-- TODO: convert to lua
vim.api.nvim_exec("nnoremap <expr> j v:count ? 'j' : 'gj'", false)
vim.api.nvim_exec("nnoremap <expr> k v:count ? 'k' : 'gk'", false)

-- move between splits
map('n', '<C-h>', ':wincmd h<cr>', default_opts)
map('n', '<C-j>', ':wincmd j<cr>', default_opts)
map('n', '<C-k>', ':wincmd k<cr>', default_opts)
map('n', '<C-l>', ':wincmd l<cr>', default_opts)
-- make splits easier
map('n', '<leader>|', '<C-w>v', default_opts)
map('n', '<leader>-', '<C-w>s', default_opts)

-- yank selection to system clipboard
map('n', '<leader>y', '*y', default_opts)

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
-- https://github.com/skbolton/titan/blob/4d0d31cc6439a7565523b1018bec54e3e8bc502c/nvim/nvim/lua/mappings/filesystem.lua#L6
map('n', '<C-p>', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", default_opts)
map('n', '<C-b>', '<cmd>:Telescope buffers<cr>', default_opts)
map('n', '<C-g>', '<cmd>:Telescope live_grep<cr>', default_opts)
-- map('n', '<C-b>', '<cmd>Telescope help_tags<cr>', default_opts)


--------------------------
-- nvim-tree
--------------------------
map('n', '<leader>?', '<cmd>:NvimTreeFindFile<cr>', default_opts)
map('n', '<leader><space>', '<cmd>:NvimTreeToggle<cr>', default_opts)
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
map('n', '<leader>p', '<cmd>:Neoformat prettier<cr>', default_opts)


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
require'lspconfig'.bashls.setup{}
require'lspconfig'.vimls.setup{}


--------------------------
-- LSP saga config
--------------------------
local saga = require 'lspsaga'
saga.init_lsp_saga {
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

map('n', '<leader>d', '<cmd>:Lspsaga hover_doc<CR>', default_opts)
map('n', 'gs', '<cmd>:Lspsaga signature_help<CR>', default_opts)
map('n', 'gr', '<cmd>:Lspsaga rename<CR>', default_opts)
-- find cursor word definition and references
map('n', 'gh', '<cmd>:Lspsaga lsp_finder<CR>', default_opts)
map('n', '<leader>gd', '<cmd>:Lspsaga preview_definition<CR>', default_opts)
-- Lsp navigation
-- go to definition
-- TODO: there are a lot more built in functions on the `vim.lsp.buf` object
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', default_opts)


--------------------------
-- completion helpers
--------------------------
require('nvim-autopairs').setup()

require('lsp_signature').setup()

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

