return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		require("mini.comment").setup({})

		require("mini.indentscope").setup({})


		require("mini.pairs").setup({})

		-- ai (enhanced text objects)
		require("mini.ai").setup({})

		require("mini.bufremove").setup({})
	end,
}
