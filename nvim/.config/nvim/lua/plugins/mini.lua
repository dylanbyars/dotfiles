return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		require("mini.comment").setup({})

		require("mini.indentscope").setup({})

		require("mini.starter").setup({
			evaluate_single = true,
			items = {
				require("mini.starter").sections.sessions(),
				require("mini.starter").sections.recent_files(10, false),
			},
			content_hooks = {
				require("mini.starter").gen_hook.adding_bullet(),
				require("mini.starter").gen_hook.aligning("center", "center"),
			},
		})

		require("mini.pairs").setup({})

		-- ai (enhanced text objects)
		require("mini.ai").setup({})

		require("mini.bufremove").setup({})
	end,
}
