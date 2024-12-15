--------------------------
-- SETTINGS
--------------------------

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.termguicolors = true

-- make the mouse work
vim.o.mouse = "a"

-- don't show mode since it's in the statusline
vim.o.showmode = false

-- always show the sign column
vim.o.signcolumn = "yes"

-- do not show the fold column (too busy)
vim.o.foldcolumn = "0"

-- start file completely unfolded
vim.o.foldlevelstart = 99

-- use treesitter to define foldable areas...
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
-- ...except for markdown. Those are folded a different way
vim.g.markdown_folding = 1

-- show the current line number on the current line and the relative line number on all other lines
vim.o.number = true
vim.o.relativenumber = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- break lines between words at window's width
vim.o.linebreak = true

-- tabs are 2 spaces wide
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- keep 1 rows of text visible at the top and bottom of screen (if possible)
vim.o.scrolloff = 1

-- persistent undo
vim.o.undofile = true
vim.bo.undofile = true

-- put new splits below or to the right
vim.o.splitbelow = true
vim.o.splitright = true

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

vim.g.sync_scroll = 0

function sync_scroll_toggle()
	if vim.g.sync_scroll == 0 then
		vim.g.sync_scroll = 1
		print("Synchronized scrolling enabled")
	else
		vim.g.sync_scroll = 0
		print("Synchronized scrolling disabled")
	end
end

vim.cmd("command! SyncScrollToggle lua sync_scroll_toggle()")

vim.cmd([[
augroup sync_scroll
    autocmd!
    autocmd CursorMoved * if g:sync_scroll == 1 | windo exe "normal! " . line(".") . "G" | endif
augroup END
]])

require("custom.functions")
require("custom.keymaps")
require("custom.plugins")
require("custom.lsp")
