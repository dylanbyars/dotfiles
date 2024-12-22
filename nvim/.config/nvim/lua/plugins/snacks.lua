return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			formats = {
				key = function(item)
					return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
				end,
			},
			sections = {
				{
					section = "terminal",
					cmd = "fortune -s | cowsay",
					hl = "header",
					padding = 1,
					indent = 8,
					random = 999999,
				},
				{
					icon = " ",
					title = "Recent Files",
					section = "recent_files",
					padding = 2,
				},
			},
		},
		indent = { enabled = true },
		input = { enabled = true },
		-- notifier = { enabled = true },
		quickfile = { enabled = true },
		-- scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		lazygit = { enabled = true },
		gitbrowse = { enabled = true },
	},
	keys = {
		{
			"<leader>lz",
			function()
				require("snacks").lazygit.open()
			end,
			desc = "open lazygit",
		},
		{
			"<leader>gy",
			function()
				require("snacks").gitbrowse()
			end,
			desc = "open in github",
			mode = { "n", "v" },
		},
		{
			"<leader>c",
			function()
				require("snacks").lazygit.log_file()
			end,
			desc = "Lazygit Current File History",
		},
	},
}
