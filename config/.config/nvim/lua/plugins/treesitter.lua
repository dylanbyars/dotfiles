-- I think this needs to happen before the `nvim-treesitter.configs` call
require("orgmode").setup_ts_grammar()

require("nvim-treesitter.configs").setup({
	-- one of "all", "maintained" (parsers with maintainers), or a list of languages
	ensure_installed = {
		"bash",
		"comment", -- highlight TODO and FIXME comments
		"css",
		"html",
		"javascript",
		"python",
		"jsdoc",
		"json",
		"lua",
		"regex",
		"scss",
		"toml",
		"tsx",
		"typescript",
		"yaml",
	},
	-- highlight adds treesitter highlighting to the words in the buffer
	highlight = {
		enable = true, -- false will disable the whole extension
		-- disable = { "c", "rust" },  -- list of language that will be disabled
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = { "org" },
		ensure_installed = { "org" }, -- Or run :TSUpdate org
	},
	rainbow = {
		enable = true,
		extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
	},
	autotag = { enable = true },
	-- incremental_selection = {
	-- enable = true,
	-- keymaps = {
	--   node_incremental = "o", -- out
	--   scope_incremental = "O", -- OUT!
	--   node_decremental = "i", -- in
	-- }
	-- },
	textsubjects = { -- TODO: may have removed this plugin for `textobjects`
		enable = true,
		prev_selection = "<M-CR>", -- alt-return -- (Optional) keymap to select the previous selection
		keymaps = {
			["<CR>"] = "textsubjects-smart",
			[";"] = "textsubjects-container-outer", -- TODO: this and the next one still don't work
			["i;"] = "textsubjects-container-inner",
		},
	},
	context_commentstring = { enable = true },
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
})
