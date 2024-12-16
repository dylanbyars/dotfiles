return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		require("mini.comment").setup({})

		require("mini.indentscope").setup({
			symbol = "⎜",
			draw = { animation = require("mini.indentscope").gen_animation.none() },
		})

		require("mini.pairs").setup({})
	end,
}
