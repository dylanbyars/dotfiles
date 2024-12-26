--------------------------
-- CORE BEHAVIOR
--------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.mouse = "a"
vim.o.undofile = true
vim.bo.undofile = true

--------------------------
-- SEARCH
--------------------------
vim.o.ignorecase = true
vim.o.smartcase = true

--------------------------
-- VISUAL DISPLAY
--------------------------
vim.o.termguicolors = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.laststatus = 3

--------------------------
-- TEXT FORMATTING
--------------------------
vim.o.linebreak = true
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.scrolloff = 1

--------------------------
-- WINDOW MANAGEMENT
--------------------------
vim.o.splitbelow = true
vim.o.splitright = true

--------------------------
-- FOLDING
--------------------------
vim.o.foldcolumn = "0"
vim.o.foldlevelstart = 99
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.g.markdown_folding = 1

--------------------------
-- COMPLETION
--------------------------
vim.o.completeopt = "menuone,noselect"

--------------------------
-- AUTOCOMMANDS
--------------------------
-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 750 })
	end,
})

-- Custom split separator color
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.cmd("highlight WinSeparator guifg=White")
	end,
})

--------------------------
-- EXTERNAL MODULES
--------------------------
require("custom.keymaps")
require("custom.plugins")
