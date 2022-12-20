vim.o.termguicolors = true -- needs to be defined before a few of the plugins

--------------------------
-- SETTINGS
--------------------------

local g = vim.g
local o = vim.o
local bo = vim.bo

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

o.smartcase = true

o.linebreak = true -- break lines between words at window's width

o.laststatus = 3 -- global status line

-- tabs are 2 spaces wide
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true

o.scrolloff = 1 -- keep 1 rows of text visible at the top and bottom of screen (if possible)

-- persistent undo
o.undofile = true
bo.undofile = true

-- put new splits below or to the right
o.splitbelow = true
o.splitright = true


-- set `cursorline` in the `NvimTree` buffer
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		local filetype = vim.opt.filetype._value -- WARN: this feels icky
		if filetype == "NvimTree" then
			vim.opt.cursorline = true
		end
	end,
})

-- highlight yanked text for a bit
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 750 })
	end,
})

-- change the color of the line between splits
-- set it after the ColorScheme event happens to add to the theme
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.cmd("highlight WinSeparator guifg=White")
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

--------------------------
-- plugin configs
--------------------------


vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, borderStyle)
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, borderStyle)
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics,
	{ underline = false }
)

-- neoformat
g.neoformat_only_msg_on_error = 1
g.neoformat_try_node_exe = 1 -- node projects with a `prettier` dependency will use the bin in `$PROJECT/node_modules/.bin`
g.shfmt_opt = "-ci" -- make `shfmt` work nicely with neovim

-- startify
vim.g.startify_change_to_vcs_root = 1
vim.g.startify_custom_header = "startify#center(startify#fortune#cowsay())"
vim.g.startify_lists = {
	{ type = "sessions", header = { " Sessions" } },
	{ type = "dir", header = { " Directory Files" } },
	{ type = "files", header = { " Recent Files" } },
}

require('custom.keymaps')
require("plugins")
