vim.o.termguicolors = true -- needs to be defined before a few of the plugins

local colors = require('colors')

require('plugins')
--------------------------
-- SETTINGS
--------------------------

local g = vim.g
local o = vim.o
local bo = vim.bo

g.tokyonight_style = 'night'
vim.cmd[[colorscheme tokyonight]]
-- change the color of the line between vertical splits
vim.cmd("highlight VertSplit guifg="..colors.magenta)

-- make the mouse work
o.mouse = 'a'

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
g.mapleader = ' '
g.maplocalleader = ' '

-- don't show mode since it's in the statusline
o.showmode = false

-- always show the sign column
o.signcolumn = 'yes'
-- do not show the fold column (too busy)
o.foldcolumn = "0"
-- start file completely unfolded
o.foldlevelstart = 99
-- use treesitter to define foldable areas
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

-- show the current line number on the current line and the relative line number on all other lines
o.number = true
o.relativenumber = true

-- don't require a file save before switching buffers
o.hidden = true

-- default to case insensitive search
o.ignorecase = true
-- break lines between words at window's width
o.linebreak = true
-- tabs are 2 spaces wide
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true

-- keep 8 rows of text visible at the top and bottom of screen (if possible)
o.scrolloff = 8

-- persistent undo
o.undofile = true
bo.undofile = true

-- put new splits below or to the right
o.splitbelow = true
o.splitright = true

-- Time in milliseconds (default 0)
g.Illuminate_delay = 750
--------------------------
-- general key bindings
--------------------------

local function map(mode, mapping, action, options)
  options = options == nil and {noremap = true} or options
  return vim.api.nvim_set_keymap(mode, mapping, action, options)
end

local function cmd(command)
  return '<cmd>'..command..'<cr>'
end

map('n', '<leader>w', cmd([[ :w ]]))
map('n', '<leader>q', cmd([[ :q ]]))
map('n', '<leader>;', ':')
map('v', '<leader>;', ':')

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

-- move between tabs
map('n', '[t', cmd([[ tabprev ]]))
map('n', ']t', cmd([[ tabnext ]]))

-- toggle spell checking mode
map('n', '<leader>s', cmd('set spell!'))

-- highlight yanked text for a bit
local hl_timeout = '750' -- ms
vim.api.nvim_command('autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout='..hl_timeout..'}')

--------------------------
-- plugin configs
--------------------------

--------------------------
-- trouble
--------------------------
map("n", "<leader>xx", cmd([[ Trouble ]]), {silent = true})
map("n", "<leader>xw", cmd([[ Trouble lsp_workspace_diagnostics ]]), {silent = true})
map("n", "<leader>xd", cmd([[ Trouble lsp_document_diagnostics ]]), {silent = true})
map("n", "<leader>xl", cmd([[ Trouble loclist ]]), {silent = true})
map("n", "<leader>xq", cmd([[ Trouble quickfix ]]), {silent = true})
map("n", "gR", cmd([[ Trouble lsp_references ]]), {silent = true})



--------------------------
-- telescope
--------------------------
local function callTelescopeBuiltin(builtin, options)
  local args = builtin..(options == nil and '()' or '('..options..')')
  return "<cmd>lua require('telescope.builtin')."..args..'<cr>'
end

-- find all files (including hidden) but NOT any files in the hidden `.git/` directory
map('n', '<leader>p', callTelescopeBuiltin('find_files', "{ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }}"))
map('n', '<leader>b', callTelescopeBuiltin('buffers') .. '<esc>')
map('n', '<leader>g', callTelescopeBuiltin('live_grep'))
map('n', '<leader>/', callTelescopeBuiltin('current_buffer_fuzzy_find')) --
map('n', '<leader>c', callTelescopeBuiltin('git_bcommits')) -- TODO: make the previewer configurable
map('n', '<leader><esc>', callTelescopeBuiltin('help_tags')) -- for quick vim `help`
map('n', '<leader>man', callTelescopeBuiltin('man_pages')) -- search for a man page, preview it, and open it in a vim buffer on <cr>
map('n', '<leader>key', callTelescopeBuiltin('keymaps')) -- search through keymaps
map('n', '<leader>S', callTelescopeBuiltin('spell_suggest')) -- show spelling suggestions for word under cursor when `spell` is set
map('n', "<leader>'", callTelescopeBuiltin('registers') .. '<esc>') -- open registers picker AND transition to normal mode
-- map('n', '=', t('grep_string')) -- not working and I don't know why
-- TODO:
-- builtin.oldfiles
-- builtin.search_history
-- builtin.marks
-- builtin.registers
-- builtin.spell_suggest
-- builtin.lsp_FOO lots here...

-- vim fugitive merge conflict resolution
map('n', '<leader>gj', cmd([[ diffget //3 ]])) -- pick the right side (incoming) change
map('n', '<leader>gf', cmd([[ diffget //2 ]])) -- pick the left side (base branch) change

--------------------------
-- neoformat
--------------------------
map('n', '<leader>f', cmd([[ :Neoformat prettier ]]))


--------------------------
-- nvim-tree
--------------------------
g.nvim_tree_width = '25%'
g.nvim_tree_auto_close = 1
g.nvim_tree_follow = 1 -- 0 by default, this option allows the cursor to be updated when entering a buffer
g.nvim_tree_add_trailing = 1 -- 0 by default, append a trailing slash to folder names
g.nvim_tree_lsp_diagnostics = 1 -- 0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
map('n', '<leader><leader>', cmd('NvimTreeToggle'))

--------------------------
-- minimap
--------------------------
-- open the minimap then move to the pane to the right to focus on it
-- the map displays the contents of whatever buffer is focused so using it with open vsplits is weird
map('n', '<leader>map', cmd([[ :MinimapToggle<cr><cmd>wincmd l ]]))
g.minimap_width = 16
g.minimap_highlight_range = 1
g.minimap_git_colors = 1
vim.cmd('hi MinimapDiffAdd guifg='..colors.green)
vim.cmd('hi MinimapDiffRemove guifg='..colors.red)
vim.cmd('hi MinimapDiff guifg='..colors.yellow)
g.minimap_diffadd_color = 'MinimapDiffAdd'
g.minimap_diffremove_color = 'MinimapDiffRemove'
g.minimap_diff_color = 'MinimapDiff'
g.minimap_cursor_color_priority	= 90


--------------------------
-- floaterm
--------------------------
g.floaterm_title = '($1/$2)'
g.floaterm_keymap_toggle = '<F12>'
g.floaterm_keymap_kill = '<F11>'
g.floaterm_keymap_new = '<F8>'
g.floaterm_keymap_prev = '<F9>'
g.floaterm_keymap_next = '<F10>'
g.floaterm_width = 0.95
g.floaterm_height = 0.95


map('n', '<leader>o', cmd([[ :OrganizeImports ]]))

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

map('n', 'K', cmd([[ :lua vim.lsp.buf.hover() ]]))
map('n', '<C-k>', cmd([[ :lua vim.lsp.buf.signature_help() ]]))
map('i', '<C-k>', cmd([[ :lua vim.lsp.buf.signature_help() ]]))
-- diagnostics
map('n', '<leader>ld', cmd([[ lua vim.lsp.diagnostic.show_line_diagnostics({ border = "single" }) ]]))
map('n', '[e', cmd([[ lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "single" }}) ]]))
map('n', ']e', cmd([[ lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "single" }}) ]]))

-- additional lsp mappings using regular lsp api
map('n', '<leader>ca', cmd([[ lua vim.lsp.buf.code_action() ]]))
map('v', '<leader>ca', cmd([[ lua vim.lsp.buf.range_code_action() ]]))
map('n', '<C-]>', cmd([[ lua vim.lsp.buf.definition() ]]))
-- rename symbol under cursor and set the rename in the command line window
map('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR><c-F>')

