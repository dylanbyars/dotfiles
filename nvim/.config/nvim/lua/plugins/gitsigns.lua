return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{ "]c", "<cmd>Gitsigns next_hunk<CR>", desc = "Next git hunk" },
		{ "[c", "<cmd>Gitsigns prev_hunk<CR>", desc = "Previous git hunk" },
		{ "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", desc = "Reset hunk" },
		{ "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>", desc = "Preview hunk" },
		{ "<leader>hb", "<cmd>Gitsigns blame_line<CR>", desc = "Blame line" },
		{ "<leader>hd", "<cmd>Gitsigns diffthis<CR>", desc = "Diff this" },
	},
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
	},
}
