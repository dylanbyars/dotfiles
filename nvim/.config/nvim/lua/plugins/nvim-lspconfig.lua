return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs to stdpath for neovim
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
    "nvimtools/none-ls.nvim", -- NOTE: the original `null-ls` project was closed. this is a renamed fork but they kept the api the same
		"jayp0521/mason-null-ls.nvim",

		-- Useful status updates for LSP
		{ "j-hui/fidget.nvim", opts = {}, tag = "legacy" },
	},
}
