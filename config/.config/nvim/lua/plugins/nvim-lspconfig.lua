return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs to stdpath for neovim
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"jose-elias-alvarez/null-ls.nvim",
		"jayp0521/mason-null-ls.nvim",

		-- Useful status updates for LSP
		{ "j-hui/fidget.nvim", opts = {} },
	},
}
