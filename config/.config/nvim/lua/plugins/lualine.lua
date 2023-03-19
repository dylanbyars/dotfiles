return {
	"nvim-lualine/lualine.nvim",
	-- dependencies = { "nvim-gps" },
	opts = {
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
			lualine_y = {
				{
					"branch",
					fmt = function(str)
						local branch_length = string.len(str)
						local max_length = 20

						if branch_length > max_length then
							return str:sub(1, max_length) .. "..."
						end

						return str
					end,
				},
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
	},
}
