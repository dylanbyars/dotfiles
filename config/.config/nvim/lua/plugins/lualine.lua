local colors = require("colors")

local gps = require("nvim-gps")
gps.setup()

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "tokyonight",
		component_separators = { "", "" },
		section_separators = { "", "" },
		disabled_filetypes = {},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			{ "filename", path = 1 }, -- 0 = just filename, 1 = relative path, 2 = absolute path
		},
		lualine_c = {
			{ gps.get_location, condition = gps.is_available },
		},
		lualine_x = { { "diff", colored = true } },
		lualine_y = { "branch" },
		lualine_z = { "progress" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
