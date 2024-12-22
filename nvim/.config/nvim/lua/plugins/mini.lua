return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		require("mini.comment").setup({})

		require("mini.pairs").setup({})

		local diff = require("mini.diff")
		diff.setup({
			-- Use signs similar to previous gitsigns config
			view = {
				style = "sign",
				signs = {
					add = "+",
					change = "~",
					delete = "_",
				},
			},
			mappings = {
				-- Use same navigation keys as before
				goto_prev = "[c",
				goto_next = "]c",
			},
			-- Center cursor after navigation
			options = {
				algorithm = "histogram",
				indent_heuristic = true,
				linematch = 60,
				-- Don't wrap around when navigating
				wrap_goto = false,
			},
		})

		-- Center cursor after navigation
		local goto_with_center = function(direction)
			return function()
				diff.goto_hunk(direction)
				vim.cmd("normal! zz")
			end
		end
		vim.keymap.set("n", "[c", goto_with_center("prev"), { desc = "Previous hunk" })
		vim.keymap.set("n", "]c", goto_with_center("next"), { desc = "Next hunk" })
	end,
}
