return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		messages = { enabled = false },
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			lsp_doc_border = true,
		},
	},
	dependencies = { "MunifTanjim/nui.nvim" },
}
