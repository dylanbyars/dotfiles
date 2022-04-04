local gps = require("nvim-gps")
gps.setup()

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "tokyonight",
		component_separators = { "", "" },
		section_separators = { "", "" },
		disabled_filetypes = {},
		disabled_filetypes = { "TelescopePrompt" },
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function(str)
					return str:sub(1, 1)
				end,
			},
		},
		lualine_b = {
			{ "filename", path = 1 }, -- 0 = just filename, 1 = relative path, 2 = absolute path
		},
		lualine_c = { { gps.get_location, condition = gps.is_available, padding = 2 } },
		lualine_x = {},
		lualine_y = {
			{
				"diff",
				colored = true,
				diff_color = {
					added = "GitSignsAdd",
					modified = "GitSignsChange",
					removed = "GitSignsDelete",
				},
				padding = 1,
			},
		},
		lualine_z = { "branch" },
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
	-- 	lualine_a = {},
	-- 	lualine_b = {},
	-- 	lualine_c = {},
	-- 	lualine_x = {},
	-- 	lualine_y = {},
	-- 	lualine_z = {},
	-- },
	extensions = {},
})
