return {
	"lewis6991/gitsigns.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local gitsigns = require("gitsigns")

		gitsigns.setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		})

    -- TODO: this doesn't work either
		vim.keymap.set("n", "[c", function()
			gitsigns.prev_hunk()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("zz", true, true, true), "n", false)
		end)
		vim.keymap.set("n", "]c", function()
			gitsigns.next_hunk()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("zz", true, true, true), "n", false)
		end)
		vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk)
		vim.keymap.set("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)
		vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk)
		vim.keymap.set("v", "<leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end)
		vim.keymap.set("n", "<leader>hS", gitsigns.undo_stage_hunk)
		vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk)
		vim.keymap.set("n", "<leader>hb", gitsigns.blame_line)
	end,
}
