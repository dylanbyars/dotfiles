--------------------------
-- telescope
--------------------------
local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		mappings = {
			i = {
				["<C-c>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,
				["<C-k>"] = actions.preview_scrolling_up,
				["<C-j>"] = actions.preview_scrolling_down,
				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = trouble.open_with_trouble,
				["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
				["<C-n>"] = false,
				["<C-p>"] = false,
				["<Down>"] = false,
				["<Up>"] = false,
				["<M-q>"] = false,
				["<C-l>"] = false,
			},

			n = {
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,
				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = trouble.open_with_trouble,
				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["H"] = actions.move_to_top,
				["M"] = actions.move_to_middle,
				["L"] = actions.move_to_bottom,
				["K"] = actions.preview_scrolling_up,
				["J"] = actions.preview_scrolling_down,
				["?"] = actions.which_key,
				["<M-q>"] = false,
				["<Down>"] = false,
				["<Up>"] = false,
			},
		},
		dynamic_preview_title = true,
		path_display = { "smart" },
		layout_config = {
			horizontal = {
				height = 0.99,
				width = 0.99,
				preview_width = 0.6,
			},
		},
	},
	extensions = {
		-- faster live_grep. I think. Should probably verify that...
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = false, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- "smart_case" (default) or "ignore_case" or "respect_case"
		},
	},
	pickers = {
		buffers = {
			ignore_current_buffer = true,
			sort_mru = true,
			mappings = {
				n = {
					-- right hand side can be the name of the action as string
					["<bs>"] = "delete_buffer",
				},
			},
			initial_mode = "normal",
		},
		spell_suggest = {
			theme = "cursor",
			initial_mode = "normal",
			layout_config = { width = 24 },
		},
		git_status = {
      theme = "dropdown",
      layout_config = { width = 0.8 },
			initial_mode = "normal",
		},
		live_grep = {
			additional_args = function()
				return { "--hidden",  }
			end,
      disable_coordinates = true
		},
	},
})

telescope.load_extension("fzf")
