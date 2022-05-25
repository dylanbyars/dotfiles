local gps = require("nvim-gps")
gps.setup()

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "tokyonight",
		component_separators = "",
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "TelescopePrompt" },
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function(str)
					return str:sub(1, 1)
				end,
				separator = { left = "", right = ""  },
			},
		},
		lualine_b = { { gps.get_location, condition = gps.is_available, padding = 2 } },
		lualine_c = {},
		lualine_x = {},
		lualine_y = {
			{ "diff", diff_color = { removed = { fg = "red" } } },
			{ "branch", separator = { right = "" } },
		},
		lualine_z = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	-- tabline = {
	-- 	lualine_a = { {'tabs', mode = 1, max_length = vim.o.columns} },
	-- 	lualine_b = {},
	-- 	lualine_c = {},
	-- 	lualine_x = {},
	-- 	lualine_y = {},
	-- 	lualine_z = {},
	-- },
	extensions = {},
})

