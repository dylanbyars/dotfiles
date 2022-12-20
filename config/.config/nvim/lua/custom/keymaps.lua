--------------------------
-- general key bindings
--------------------------

local function cmd(command)
	return "<cmd>" .. command .. "<cr>"
end

local setKeymap = vim.keymap.set

local lspRename = require("textcase").lsp_rename
local currentWord = require("textcase").current_word
-- TODO: this fails when the word is against something e.g. fooBar(baz) -> can't cycle fooBar
local function cycleCase()
	-- TODO: I don't need 2 tables. join them somehow.
	-- TODO: these could be more robust
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
		["<leader>t"] = cmd("NvimTreeToggle"),
		["<leader>hh"] = cmd("set cursorline!"),
		["<leader>w"] = cmd("w"),
		["<leader>q"] = cmd("q"),
		["<leader>so"] = cmd("source ~/.config/nvim/init.lua"),
		-- make splits easier
		["<leader>\\"] = "<C-w>v",
		["<leader>-"] = "<C-w>s",
		-- move between tabs
		["[t"] = cmd("tabprev"),
		["]t"] = cmd(" tabnext "),
		-- rearrange tabs
		["[T"] = cmd("-tabmove"),
		["]T"] = cmd("+tabmove"),
		-- spell check
		["<leader>s"] = cmd("set spell!"), -- toggle spell checking mod
		-- yank selection to system clipboard
		["<leader>y"] = '"+y',
		-- navigate to start/end of line
		["H"] = "^",
		["L"] = "$",
		["U"] = "<C-r>", -- u = undo  U = undo undo aka redo,
		["<leader>lz"] = cmd("Lazygit"),
		-- ["<leader>!"] = cmd("lua print(vim.fn.expand('<cword>'))")
		["<leader>_"] = cycleCase,
		-- ["_"] = cmd("lua require('textcase').lsp_rename(to_camel_case)") -- TODO: make this cycle through severl cases and `+` cycle the other way
		["<leader>o"] = cmd("SymbolsOutline"),
		-- jump a half page then center the screen on the cursor's line
		["<C-u>"] = "<C-u>zz",
		["<C-d>"] = "<C-d>zz",
		["<leader>x"] = cmd("lua vim.diagnostic.disable()"),
		["<leader>X"] = cmd("lua vim.diagnostic.enable()"),
		["<leader>n"] = cmd(":noh"), -- clear current search highlight
		-- <trouble>
		["<leader>xx"] = cmd("TroubleToggle quickfix"),
		["<leader>xw"] = cmd("Trouble workspace_diagnostics"),
		["<leader>xd"] = cmd("Trouble document_diagnostics"),
		["gR"] = cmd("Trouble lsp_references"),
		-- </trouble>
		["<leader>js"] = function()
			open_scratch_buffer("json")
		end,
		["<leader>br"] = cmd("Broot %:h"), -- open broot in the directory of the current buffer
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
		setKeymap(mode, keymap, action)
	end
end


-- map j and k to gj and gk so that they move from visual line to visual line when j or k is pressed but move from real line to real line when jumping some number of lines across visually wrapped lines
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


--------------------------
-- telescope
--------------------------
local function callTelescopeBuiltin(builtin)
	return "<cmd>lua require('telescope.builtin')." .. builtin .. "<cr>"
end

-- vim.api.nvim_set_keymap("n", "<Leader><Space>", "<CMD>lua require'telescope-config'.project_files()<CR>", {noremap = true, silent = true})
setKeymap({ "n", "i" }, "<C-p>", "<CMD>lua require'plugins.telescope'.project_files()<CR>", { silent = true })
setKeymap("n", "<leader>b", callTelescopeBuiltin("buffers()"))
setKeymap("n", "<leader>/", callTelescopeBuiltin("live_grep()"))
setKeymap("n", "<leader>c", callTelescopeBuiltin("git_bcommits()"))
setKeymap("n", "<leader>gs", callTelescopeBuiltin("git_status()")) -- show files with a git status
setKeymap("n", "<leader>?", callTelescopeBuiltin("help_tags()")) -- for quick vim `help`
setKeymap("n", "<leader>S", callTelescopeBuiltin("spell_suggest()")) -- show spelling suggestions for word under cursor when `spell` is set
setKeymap("n", "<leader>*", callTelescopeBuiltin("grep_string()")) -- search entire project for string under cursor
setKeymap("n", "<leader>T", callTelescopeBuiltin("resume()")) -- reopen the last Telescope window
setKeymap("n", "<leader>j", callTelescopeBuiltin("jumplist()")) -- reopen the last Telescope window
setKeymap("n", "?", callTelescopeBuiltin("current_buffer_fuzzy_find()")) -- replace the default search fuzzy find in the current buffer

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

--------------------------
-- LSP
--------------------------
local borderStyle = { border = "double", max_width = 90 }
setKeymap("n", "<leader>O", cmd(":OrganizeImports"))

setKeymap("n", "K", cmd(":lua vim.lsp.buf.hover()")) -- go to floating window by pressing `K` again
setKeymap({ "n", "i" }, "<C-k>", cmd(":lua vim.lsp.buf.signature_help()"))
-- diagnostics
setKeymap("n", "<leader>ld", cmd('lua vim.diagnostic.open_float({ border = "rounded" })'))
setKeymap("n", "[e", cmd("lua vim.diagnostic.goto_prev({ float = false })"))
setKeymap("n", "]e", cmd("lua vim.diagnostic.goto_next({ float = false })"))

-- additional lsp mappings using regular lsp api
setKeymap("n", "<leader>ca", cmd("lua vim.lsp.buf.code_action()"))
setKeymap("v", "<leader>ca", cmd("lua vim.lsp.buf.range_code_action()"))
setKeymap("n", "<leader>d", cmd("split | lua vim.lsp.buf.definition()")) -- go to definition in split
setKeymap("n", "<leader>D", cmd("lua vim.lsp.buf.definition()")) -- go to definition in current buffer
setKeymap("n", "<leader>r", cmd("lua vim.lsp.buf.rename()")) -- rename symbol under cursor
