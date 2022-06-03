-- winbar stuff
_G.gps_location = function()
	local gps = require("nvim-gps")
	gps.setup()
	return gps.is_available() and gps.get_location() or ""
end

vim.opt.winbar = " %{%v:lua.gps_location()%}"

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "tokyonight",
		component_separators = "",
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "TelescopePrompt" },
	},
	sections = {
		lualine_a = { "progress" },
		lualine_b = { { "filename", path = 1 } },
		lualine_c = {},
		lualine_x = { "diff" },
		lualine_y = { "branch" },
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
