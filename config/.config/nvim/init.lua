--------------------------
-- SETTINGS
--------------------------
vim.o.termguicolors = true 

-- make the mouse work
vim.o.mouse = "a"

-- Set <space> as the leader key
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.showmode = false -- don't show mode since it's in the statusline

vim.o.signcolumn = "yes" -- always show the sign column

vim.o.foldcolumn = "0" -- do not show the fold column (too busy)

vim.o.foldlevelstart = 99 -- start file completely unfolded

vim.wo.foldmethod = "expr" -- use treesitter to define foldable areas
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"

-- show the current line number on the current line and the relative line number on all other lines
vim.o.number = true
vim.o.relativenumber = true

vim.o.incsearch = true
vim.o.smartcase = true

vim.o.linebreak = true -- break lines between words at window's width

vim.o.laststatus = 3 -- global status line

-- tabs are 2 spaces wide
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.o.scrolloff = 1 -- keep 1 rows of text visible at the top and bottom of screen (if possible)

-- persistent undo
vim.o.undofile = true
vim.bo.undofile = true

-- put new splits below or to the right
vim.o.splitbelow = true
vim.o.splitright = true

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

require('custom.keymaps')
require('custom.plugins')
require("custom.lsp")
