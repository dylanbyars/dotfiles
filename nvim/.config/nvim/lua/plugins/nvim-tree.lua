return {
	"kyazdani42/nvim-tree.lua",
	dependencies = { "kyazdani42/nvim-web-devicons" },
	opts = {
		view = {
			adaptive_size = true,
			centralize_selection = true,
			-- side = "right",
		},
		update_focused_file = {
			enable = true,
		},
	},
	keys = {
		{
			"<leader>t",
			function()
				vim.cmd("NvimTreeToggle")
			end,
			desc = "[t]oggle file tree",
		},
	},
}
