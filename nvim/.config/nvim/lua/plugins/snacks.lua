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
			sections = {
        -- TODO: maybe I don't want this in neovim. maybe this is a terminal thing that I add to my prompts?
				-- {
				-- 	section = "terminal",
				-- 	cmd = "fortune -n 400 -s computers science startrek linuxcookie riddles literature wisdom work humorists platitudes | fmt -w 999999",
				-- 	hl = "header",
				-- 	padding = 1,
				-- 	random = 999999,
				-- },
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
