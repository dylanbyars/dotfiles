--------------------------
-- general key bindings
--------------------------
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- TODO: this fails when the word is against something e.g. fooBar(baz) -> can't cycle fooBar
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

local KEYMAPS = {
	["n"] = {
		["<leader>t"] = function()
			vim.cmd("NvimTreeToggle")
		end,
		["<leader>hh"] = function()
			vim.cmd("set cursorline!")
		end,
		["<leader>w"] = function()
			vim.cmd("w")
		end,
		["<leader>q"] = function()
			vim.cmd("q")
		end,
		["<leader>so"] = function()
			vim.cmd("source ~/.config/nvim/init.lua")
		end,
		-- make splits easier
		["<leader>\\"] = "<C-w>v",
		["<leader>-"] = "<C-w>s",
		-- move between tabs
		["[t"] = function()
			vim.cmd("tabprev")
		end,
		["]t"] = function()
			vim.cmd("tabnext")
		end,
		-- rearrange tabs
		["[T"] = function()
			vim.cmd("-tabmove")
		end,
		["]T"] = function()
			vim.cmd("+tabmove")
		end,
		-- spell check
		["<leader>s"] = function()
			vim.cmd("set spell!")
		end, -- toggle spell checking moendd
		-- yank selection to system clipboard
		["<leader>y"] = '"+y',
		-- navigate to start/end of line
		["H"] = "^",
		["L"] = "$",
		["U"] = "<C-r>", -- u = undo  U = undo undo aka redo,
		["<leader>lz"] = function()
			vim.cmd("Lazygit")
		end,
		-- ["<leader>!"] = vim.cmd("lua print(vim.fn.expand('<cword>'))")
		["<leader>_"] = cycleCase,
		-- ["_"] = vim.cmd("lua require('textcase').lsp_rename(to_camel_case)") -- TODO: make this cycle through severl cases and `+` cycle the other way
		-- jump a half page then center the screen on the cursor's line
		["<C-u>"] = "<C-u>zz",
		["<C-d>"] = "<C-d>zz",
		["<leader>x"] = vim.diagnostic.disable,
		["<leader>X"] = function()
			vim.cmd("lua vim.diagnostic.enable()")
		end,
		["<leader>n"] = function()
			vim.cmd(":noh")
		end, -- clear current search highlighendt
		-- <trouble>
		["<leader>xx"] = function()
			vim.cmd("TroubleToggle quickfix")
		end,
		["<leader>xw"] = function()
			vim.cmd("Trouble workspace_diagnostics")
		end,
		["<leader>xd"] = function()
			vim.cmd("Trouble document_diagnostics")
		end,
		["gR"] = function()
			vim.cmd("Trouble lsp_references")
		end,
		-- </trouble>
		["<leader>js"] = function()
			open_scratch_buffer("json")
		end,
		["<leader>br"] = function()
			vim.cmd("Broot %:h")
		end, -- open broot in the directory of the current buffeendr
		-- open closed folds at the top of the fold
		["za"] = "za[z",
		["zA"] = "zA[z",
		["zo"] = "zo[z",
		["zO"] = "zO[z",
	},
	["v"] = {
		["<leader>y"] = '"+y', -- yank selection to system clipboard
		-- navigate to start/end of line
		["H"] = "^",
		["L"] = "$",
	},
}

for mode, maps in pairs(KEYMAPS) do
	for keymap, action in pairs(maps) do
		vim.keymap.set(mode, keymap, action)
	end
end

-- map j and k to gj and gk so that they move from visual line to visual line when j or k is pressed but move from real line to real line when jumping some number of lines across visually wrapped lines
local function move_line(j_or_k)
	if vim.v.count == 0 then
		return "g" .. j_or_k
	else
		return j_or_k
	end
end

vim.keymap.set("n", "j", function()
	return move_line("j")
end, { expr = true, silent = true })
vim.keymap.set("n", "k", function()
	return move_line("k")
end, { expr = true, silent = true })

