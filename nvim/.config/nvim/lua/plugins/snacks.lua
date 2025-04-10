return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		bigfile = { enabled = true },
		dashboard = {
			enabled = true,
			formats = {
				key = function(item)
					return { { "[", hl = "special" }, { item.key, hl = "key" }, { "]", hl = "special" } }
				end,
			},
      width = 80,
			sections = {
				{
					section = "terminal",
					cmd = "fortune ~/clippings.fortune | fold -s -w 80",
					-- hl = "header",
          random = 99999
				},
				{
					title = "Recent Files",
					section = "recent_files",
					padding = 1,
					limit = 10,
					cwd = true,
				},
			},
		},
		indent = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		lazygit = { enabled = true },
		gitbrowse = { enabled = true },
		styles = {
			blame_line = {
				width = 0.6,
				height = 0.6,
				border = "rounded",
				title = " Git Blame ",
				title_pos = "center",
				ft = "git",
			},
		},
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
			"<leader>gc",
			function()
				require("snacks").lazygit.log_file()
			end,
			desc = "Lazygit Current File History",
		},
	},
}
