vim.o.termguicolors = true -- needs to be defined before a few of the plugins

local colors = require("colors")

require("plugins")
--------------------------
-- SETTINGS
--------------------------

local g = vim.g
local o = vim.o
local bo = vim.bo

g.tokyonight_style = "night"
vim.cmd([[colorscheme tokyonight]])
-- change the color of the line between vertical splits
vim.cmd("highlight VertSplit guifg=" .. colors.magenta)

-- make the mouse work
o.mouse = "a"

--Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = " "

o.showmode = false -- don't show mode since it's in the statusline

o.signcolumn = "yes" -- always show the sign column

o.foldcolumn = "0" -- do not show the fold column (too busy)

o.foldlevelstart = 99 -- start file completely unfolded

vim.wo.foldmethod = "expr" -- use treesitter to define foldable areas
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

-- show the current line number on the current line and the relative line number on all other lines
o.number = true
o.relativenumber = true

o.ignorecase = true -- default to case insensitive search

o.linebreak = true -- break lines between words at window's width

-- tabs are 2 spaces wide
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true

o.scrolloff = 8 -- keep 8 rows of text visible at the top and bottom of screen (if possible)

-- persistent undo
o.undofile = true
bo.undofile = true

-- put new splits below or to the right
o.splitbelow = true
o.splitright = true

g.Illuminate_delay = 750 -- Time in milliseconds (default 0)
--------------------------
-- general key bindings
--------------------------

local function map(mode, mapping, action, options)
	options = options == nil and { noremap = true } or options
	return vim.api.nvim_set_keymap(mode, mapping, action, options)
end

local function cmd(command)
	return "<cmd>" .. command .. "<cr>"
end

map("n", "<leader>w", cmd([[ :w ]]))
map("n", "<leader>q", cmd([[ :q ]]))

-- map j and k to gj and gk so that they move from visual line to visual line when j or k is
-- pressed but move from real line to real line when jumping some number of
-- lines across visually wrapped lines
-- TODO: convert to lua
vim.api.nvim_exec("nnoremap <expr> j v:count ? 'j' : 'gj'", false)
vim.api.nvim_exec("nnoremap <expr> k v:count ? 'k' : 'gk'", false)

-- move between splits with arrow keys
map("n", "<left>", ":wincmd h<cr>")
map("n", "<down>", ":wincmd j<cr>")
map("n", "<up>", ":wincmd k<cr>")
map("n", "<right>", ":wincmd l<cr>")
-- make splits easier
map("n", "<leader>\\", "<C-w>v")
map("n", "<leader>-", "<C-w>s")

-- yank selection to system clipboard
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')

-- move between tabs
map("n", "[t", cmd([[ tabprev ]]))
map("n", "]t", cmd([[ tabnext ]]))

map("n", "<leader>s", cmd("set spell!")) -- toggle spell checking mode

-- highlight yanked text for a bit
local hl_timeout = "750" -- ms
vim.api.nvim_command(
	'autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=' .. hl_timeout .. "}"
)

-- navigate to start/end of line
map("n", "H", "^")
map("v", "H", "^")
map("n", "L", "$")
map("v", "L", "$")

map("n", "U", "<C-r>") -- u = undo  U = undo undo aka redo

--------------------------
-- plugin configs
--------------------------

--------------------------
-- trouble
--------------------------
map("n", "<leader>xx", cmd([[ Trouble ]]), { silent = true })
map("n", "<leader>xw", cmd([[ Trouble lsp_workspace_diagnostics ]]), { silent = true })
map("n", "<leader>xd", cmd([[ Trouble lsp_document_diagnostics ]]), { silent = true })
map("n", "<leader>xl", cmd([[ Trouble loclist ]]), { silent = true })
map("n", "<leader>xq", cmd([[ Trouble quickfix ]]), { silent = true })
map("n", "gR", cmd([[ Trouble lsp_references ]]), { silent = true })
map("n", "gI", cmd([[ Trouble lsp_implementations ]]), { silent = true })

--------------------------
-- telescope
--------------------------
local function callTelescopeBuiltin(builtin)
	return "<cmd>lua require('telescope.builtin')." .. builtin .. "<cr>"
end

map("n", "<C-p>", callTelescopeBuiltin("git_files()"))
map("i", "<C-p>", callTelescopeBuiltin("git_files()"))
map("n", "<leader>b", callTelescopeBuiltin("buffers()"))
map("n", "<leader>?", callTelescopeBuiltin("live_grep()"))
map("n", "<leader>/", callTelescopeBuiltin("current_buffer_fuzzy_find()"))
map("n", "<leader>c", callTelescopeBuiltin("git_bcommits()"))-- TODO: make the previewer configurable
map("n", "<leader><esc>", callTelescopeBuiltin("help_tags()")) -- for quick vim `help`
map("n", "<leader>man", callTelescopeBuiltin("man_pages()")) -- search for a man page, preview it, and open it in a vim buffer on <cr>
map("n", "<leader>key", callTelescopeBuiltin("keymaps()")) -- search through keymaps
map("n", "<leader>S", callTelescopeBuiltin("spell_suggest()")) -- show spelling suggestions for word under cursor when `spell` is set

-- vim fugitive merge conflict resolution
map("n", "<leader>gj", cmd([[ diffget //3 ]])) -- pick the right side (incoming) change
map("n", "<leader>gf", cmd([[ diffget //2 ]])) -- pick the left side (base branch) change

--------------------------
-- neoformat
--------------------------
map("n", "<leader>f", cmd([[ :Neoformat ]]))
g.neoformat_only_msg_on_error = 1
g.neoformat_try_node_exe = 1 -- node projects with a `prettier` dependency will use the bin in `$PROJECT/node_modules/.bin`
g.shfmt_opt = "-ci" -- make `shfmt` work nicely with neovim

--------------------------
-- LSP
--------------------------

local borderStyle = { border = "double" }

map("n", "<leader>o", cmd([[ :OrganizeImports ]]))

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, borderStyle)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, borderStyle)
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics,
	{ virtual_text = false }
)

map("n", "K", cmd([[ :lua vim.lsp.buf.hover() ]]))
map("n", "<C-k>", cmd([[ :lua vim.lsp.buf.signature_help() ]]))
map("i", "<C-k>", cmd([[ :lua vim.lsp.buf.signature_help() ]]))
-- diagnostics
map("n", "<leader>ld", cmd([[ lua vim.lsp.diagnostic.show_line_diagnostics({ border = "double" }) ]]))
map("n", "[e", cmd([[ lua vim.lsp.diagnostic.goto_prev({ popup_opts = { border = "double" }}) ]]))
map("n", "]e", cmd([[ lua vim.lsp.diagnostic.goto_next({ popup_opts = { border = "double" }}) ]]))

-- additional lsp mappings using regular lsp api
map("n", "<leader>ca", cmd([[ lua vim.lsp.buf.code_action() ]]))
map("v", "<leader>ca", cmd([[ lua vim.lsp.buf.range_code_action() ]]))
map("n", "<leader>d", cmd([[ lua vim.lsp.buf.definition() ]]))

map("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR><c-F>") -- rename symbol under cursor and set the rename in the command line window

-- vimwiki
vim.api.nvim_command("set nocompatible")
vim.api.nvim_command("filetype plugin on")
vim.api.nvim_command("syntax on")
g.vimwiki_global_ext = 0 -- prevents vimwiki from treating all .md files as part of a wiki

map("n", "<leader><leader>", cmd([[ Broot %:h ]])) -- open broot in the directory of the current buffer

-- symbols_outline
g.symbols_outline = {
	highlight_hovered_item = false,
	width = 100,
	position = "left",
	auto_preview = false,
}
map("n", "<C-s>", cmd([[ SymbolsOutline ]]))
