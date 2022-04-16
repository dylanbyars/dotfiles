vim.o.termguicolors = true -- needs to be defined before a few of the plugins

--------------------------
-- SETTINGS
--------------------------

local g = vim.g
local o = vim.o
local bo = vim.bo

g.tokyonight_style = "night"
vim.cmd("colorscheme tokyonight")
-- change the color of the line between vertical splits
vim.cmd("highlight VertSplit guifg=white")
vim.cmd("highlight VertSplit guifg=white")

-- make the mouse work
o.mouse = "a"

--Remap space as leader key
vim.keymap.set({ "n" }, "<Space>", "<Nop>", { silent = true })
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

o.laststatus = 2

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

--------------------------
-- general key bindings
--------------------------

local function cmd(command)
	return "<cmd>" .. command .. "<cr>"
end

local setKeymap = vim.keymap.set

setKeymap("n", "<leader>w", cmd("w"))
setKeymap("n", "<leader>q", cmd("q"))

-- map j and k to gj and gk so that they move from visual line to visual line when j or k is
-- pressed but move from real line to real line when jumping some number of
-- lines across visually wrapped lines
-- TODO: convert to lua
vim.api.nvim_exec("nnoremap <expr> j v:count ? 'j' : 'gj'", false)
vim.api.nvim_exec("nnoremap <expr> k v:count ? 'k' : 'gk'", false)

-- make splits easier
setKeymap("n", "<leader>\\", "<C-w>v")
setKeymap("n", "<leader>-", "<C-w>s")

-- yank selection to system clipboard
setKeymap("n", "<leader>y", '"+y')
setKeymap("v", "<leader>y", '"+y')

-- move between tabs
setKeymap("n", "[t", cmd("tabprev"))
setKeymap("n", "]t", cmd(" tabnext "))
-- move tabs
setKeymap("n", "[T", cmd("-tabmove"))
setKeymap("n", "]T", cmd("+tabmove"))

setKeymap("n", "<leader>s", cmd("set spell!")) -- toggle spell checking mode

-- highlight yanked text for a bit
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 750 })
	end,
})

-- change the background of non-focused windows (NC means non-current)
vim.api.nvim_set_hl(0, "NonCurrentWindow", { ctermbg = "gray" })
vim.api.nvim_create_autocmd("WinEnter", {
	pattern = "*",
	callback = function()
		vim.opt.winhighlight = "Normal:BufferVisible,NormalNC:NonCurrentWindow"
	end,
})

-- run some scripts when saving js/ts files
vim.api.nvim_create_autocmd("BufWrite", {
	pattern = { "*.js", "*.jsx", "*.ts", "*.tsx" },
	command = "Neoformat prettier | EslintFixAll",
})

-- navigate to start/end of line
setKeymap({ "n", "v" }, "H", "^")
setKeymap({ "n", "v" }, "L", "$")

setKeymap("n", "U", "<C-r>") -- u = undo  U = undo undo aka redo

--------------------------
-- plugin configs
--------------------------

--------------------------
-- trouble
--------------------------
setKeymap("n", "<leader>xx", cmd("Trouble"), { silent = true })
setKeymap("n", "<leader>xw", cmd("Trouble lsp_workspace_diagnostics"), { silent = true })
setKeymap("n", "<leader>xd", cmd("Trouble lsp_document_diagnostics"), { silent = true })
setKeymap("n", "<leader>xl", cmd("Trouble loclist"), { silent = true })
setKeymap("n", "<leader>xq", cmd("Trouble quickfix"), { silent = true })
setKeymap("n", "gR", cmd("Trouble lsp_references"), { silent = true })

--------------------------
-- telescope
--------------------------
local function callTelescopeBuiltin(builtin)
	return "<cmd>lua require('telescope.builtin')." .. builtin .. "<cr>"
end

-- vim.api.nvim_set_keymap("n", "<Leader><Space>", "<CMD>lua require'telescope-config'.project_files()<CR>", {noremap = true, silent = true})
setKeymap({ "n", "i" }, "<C-p>", "<CMD>lua require'plugins.telescope'.project_files()<CR>", { silent = true })
setKeymap("n", "<leader>b", callTelescopeBuiltin("buffers()"))
setKeymap("n", "<leader>?", callTelescopeBuiltin("live_grep()"))
setKeymap("n", "<leader>/", callTelescopeBuiltin("current_buffer_fuzzy_find()"))
setKeymap("n", "<leader>c", callTelescopeBuiltin("git_bcommits()"))
setKeymap("n", "<leader>gs", callTelescopeBuiltin("git_status()")) -- show files with a git status
setKeymap("n", "<leader><esc>", callTelescopeBuiltin("help_tags()")) -- for quick vim `help`
setKeymap("n", "<leader>S", callTelescopeBuiltin("spell_suggest()")) -- show spelling suggestions for word under cursor when `spell` is set

--------------------------
-- gitsigns
--------------------------
setKeymap("n", "[c", function()
	require("gitsigns").prev_hunk()
end)
setKeymap("n", "]c", function()
	require("gitsigns").next_hunk()
end)
setKeymap("n", "<leader>hr", function()
	require("gitsigns").reset_hunk()
end)
setKeymap("v", "<leader>hr", function()
	require("gitsigns").reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end)
setKeymap("n", "<leader>hp", function()
	require("gitsigns").preview_hunk()
end)
setKeymap("n", "<leader>hb", function()
	require("gitsigns").blame_line()
end)

--------------------------
-- neoformat
--------------------------
setKeymap("n", "<leader>f", cmd(":Neoformat"))
g.neoformat_only_msg_on_error = 1
g.neoformat_try_node_exe = 1 -- node projects with a `prettier` dependency will use the bin in `$PROJECT/node_modules/.bin`
g.shfmt_opt = "-ci" -- make `shfmt` work nicely with neovim

--------------------------
-- LSP
--------------------------
local borderStyle = { border = "double" }

setKeymap("n", "<leader>o", cmd(":OrganizeImports"))

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, borderStyle)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, borderStyle)
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics,
	{ virtual_text = false }
)

setKeymap("n", "K", cmd(":lua vim.lsp.buf.hover()"))
setKeymap({ "n", "i" }, "<C-k>", cmd(":lua vim.lsp.buf.signature_help()"))
-- diagnostics
setKeymap("n", "<leader>ld", cmd('lua vim.diagnostic.open_float({ border = "rounded" })'))
setKeymap("n", "[e", cmd('lua vim.diagnostic.goto_prev({ float = { border = "rounded" }})'))
setKeymap("n", "]e", cmd('lua vim.diagnostic.goto_next({ float = { border = "rounded" }})'))

-- additional lsp mappings using regular lsp api
setKeymap("n", "<leader>ca", cmd("lua vim.lsp.buf.code_action()"))
setKeymap("v", "<leader>ca", cmd("lua vim.lsp.buf.range_code_action()"))
setKeymap("n", "<leader>d", cmd("lua vim.lsp.buf.definition()"))
-- TODO: open the definition in a floating window (plenary.window)
setKeymap("n", "<leader>D", cmd("tab split | lua vim.lsp.buf.definition()"))

setKeymap("n", "<leader>r", cmd("lua vim.lsp.buf.rename()")) -- rename symbol under cursor

-- vimwiki
vim.api.nvim_command("set nocompatible")
vim.api.nvim_command("filetype plugin on")
vim.api.nvim_command("syntax on")
g.vimwiki_global_ext = 0 -- prevents vimwiki from treating all .md files as part of a wiki

setKeymap("n", "<leader><leader>", cmd("Broot %:h")) -- open broot in the directory of the current buffer

-- startify
vim.g.startify_change_to_vcs_root = 1
vim.g.startify_custom_header = "startify#center(startify#fortune#cowsay())"
vim.g.startify_lists = {
	{ type = "sessions", header = { " Sessions" } },
	{ type = "dir", header = { " Directory Files" } },
	{ type = "files", header = { " Recent Files" } },
}

require("plugins")
