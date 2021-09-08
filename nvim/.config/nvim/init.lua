vim.o.termguicolors = true -- needs to be defined before a few of the plugins

local colors = require('colors')

require('plugins')
--------------------------
-- SETTINGS
--------------------------

local g = vim.g
local o = vim.o

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

-- persistent undo TODO: not working
-- vim.bo.undo = true
-- g.undodir = '~/.config/nvim/undo'

-- put new splits below or to the right
o.splitbelow = true
o.splitright = true

-- Time in milliseconds (default 0)
g.Illuminate_delay = 1000
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

-- toggle fold TODO: make this smarter. if the fold is closed, run zO to open it ALL up. If it's open, run whatever completely closes the biggest surrounding fold
map('n', '<S-Tab>', 'za')

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

-- the unimpaired plugin uses these mappings to navigate tags
-- taBs are more relevant to me than taGs
map('n', '[t', '<cmd>tabprev<cr>')
map('n', ']t', '<cmd>tabnext<cr>')

-- highlight yanked text for a bit
local hl_timeout = '750' -- ms
vim.api.nvim_command('autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout='..hl_timeout..'}')

--------------------------
-- plugin configs
--------------------------


--------------------------
-- startify
--------------------------
g.startify_change_to_vcs_root = 1
g.startify_custom_header = 'startify#center(startify#fortune#cowsay())'
g.startify_lists = {
  {type = 'bookmarks', header = {' Projects'}},
  {type = 'files', header = {' Recent Files'}},
  {type = 'sessions', header = {' Sessions'}}
}
g.startify_bookmarks = {
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
-- trouble
--------------------------
map("n", "<leader>xx", "<cmd>Trouble<cr>", {silent = true})
map("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>", {silent = true})
map("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>", {silent = true})
map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", {silent = true})
map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", {silent = true})
map("n", "gR", "<cmd>Trouble lsp_references<cr>", {silent = true})


--------------------------
-- hop
--------------------------
map('n', 'm', '<cmd>:HopChar2<cr>')

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
-- map('n', "<leader>'", '<cmd>Telescope neoclip<cr><esc>') -- open neoclip menu AND transition to normal mode
-- map('n', '=', t('grep_string')) -- not working and I don't know why
-- TODO:
-- builtin.oldfiles
-- builtin.search_history
-- builtin.marks
-- builtin.registers
-- builtin.spell_suggest
-- builtin.lsp_FOO lots here...

--------------------------
-- nvim-tree
--------------------------
map('n', '<leader><leader>', '<cmd>:NvimTreeFindFile<cr>')
-- TODO: switch focus back to the previous pane. currently focus moves to the pane closest to the tree
map('n', '<esc>', '<cmd>:NvimTreeClose<cr>')
-- g.nvim_tree_follow = 1 -- TODO: this shows the whole file system, not just the vcs root's folder
g.nvim_tree_highlight_opened_files = 3
g.nvim_tree_hide_dotfiles = 0
g.nvim_tree_width = '25%'

-- vim fugitive merge conflict resolution
map('n', '<leader>gj', '<cmd>diffget //3<cr>') -- pick the right side (incoming) change
map('n', '<leader>gf', '<cmd>diffget //2<cr>') -- pick the left side (base branch) change

--------------------------
-- neoformat
--------------------------
map('n', '<leader>f', '<cmd>:Neoformat prettier<cr>')


--------------------------
-- minimap
--------------------------
-- open the minimap then move to the pane to the right to focus on it
-- the map displays the contents of whatever buffer is focused so using it with open vsplits is weird
map('n', '<leader>map', '<cmd>:MinimapToggle<cr><cmd>wincmd l<cr>')
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


map('n', '<leader>o', '<cmd>:OrganizeImports<cr>')

-- TODO: not working and idk why
-- map('n', '<leader><up>', '<cmd>lua require"illuminate".next_reference{reverse=true, wrap=true}<cr>')
-- map('n', '<leader><down>', '<cmd>lua require"illuminate".next_reference{wrap=true}<cr>')


map('n', 'K', '<cmd>:Lspsaga hover_doc<CR>')
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
-- TODO: trouble obsoletes these
-- view references in the quickfix list
-- map('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
-- -- view all diagnostics in the file in the quickfix list
-- map('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.set_qflist()<CR>')


vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', {expr = true})
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', {expr = true})
-- Map compe confirm and complete functions
vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })

