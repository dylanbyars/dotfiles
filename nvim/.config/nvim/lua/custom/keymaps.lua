-- Helper Functions
local function cycleCase()
	local lspRename = require("textcase").lsp_rename
	local currentWord = require("textcase").current_word

	-- TODO: I don't need 2 tables. join them somehow. and these patterns could be more robust
	local patterns = {
		camel = "^%l+%u%l", -- fooBar
		snake = "^%l+%_%l", -- foo_bar
		constant = "^%u+%_%u", -- FOO_BAR
		pascal = "^%u%l+%u", -- FooBar
	}

	local transformations = {
		snake = "camel",
		camel = "pascal",
		pascal = "constant",
		constant = "snake",
	}

	for name, pattern in pairs(patterns) do
		if string.find(vim.fn.expand("<cword>"), pattern) then
			local command = "to_" .. transformations[name] .. "_case"
			lspRename(command)
			currentWord(command)
		end
	end
end

local function open_scratch_buffer(filetype)
	vim.cmd("split")
	local win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_create_buf(true, true)
	vim.api.nvim_win_set_buf(win, buf)
	-- NOTE: looks like buffer names need to be unique
	vim.api.nvim_buf_set_name(buf, "SCRATCH [" .. filetype .. "]" .. " -- " .. buf)
	vim.cmd("set filetype=" .. filetype)
end

local set = vim.keymap.set

-- Shared mappings
set({ "n", "v" }, "H", "^", { desc = "Start of line" })
set({ "n", "v" }, "L", "$", { desc = "End of line" })
set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
set({ "n", "v" }, "<Space>", "<Nop>", { silent = true, desc = "this is the leader key" })

-- Normal mode mappings
set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save buffer" })
set("n", "<leader>q", "<cmd>q<cr>", { desc = "Quit buffer" })
set("n", "<leader>so", "<cmd>source ~/.config/nvim/init.lua<cr>", { desc = "Source init.lua" })
set("n", "<leader>\\", "<C-w>v", { desc = "Split vertically" })
set("n", "<leader>-", "<C-w>s", { desc = "Split horizontally" })
set("n", "[t", "<cmd>tabprev<cr>", { desc = "Previous tab" })
set("n", "]t", "<cmd>tabnext<cr>", { desc = "Next tab" })
set("n", "[T", "<cmd>-tabmove<cr>", { desc = "Move tab left" })
set("n", "]T", "<cmd>+tabmove<cr>", { desc = "Move tab right" })
set("n", "<leader>hh", "<cmd>set cursorline!<cr>", { desc = "Toggle cursor line" })
set("n", "<leader>s", "<cmd>set spell!<cr>", { desc = "Toggle spell check" })
set("n", "<leader>#", "<cmd>set relativenumber!<cr>", { desc = "Toggle relative numbers" })
set("n", "<leader>X", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle inline diagnostics" })
set("n", "<C-u>", "<C-u>zz", { desc = "Half page up and center" })
set("n", "<C-d>", "<C-d>zz", { desc = "Half page down and center" })
set("n", "<leader>n", "<cmd>noh<cr>", { desc = "Clear search highlight" })
set("n", "U", "<C-r>", { desc = "Redo" })
set("n", "<leader>_", cycleCase, { desc = "Cycle case" })
set("n", "<leader>js", function()
	open_scratch_buffer("json")
end, { desc = "Open JSON scratch buffer" })

-- Word wrap navigation
set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
