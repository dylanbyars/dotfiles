-- search improvements
return {
	"folke/trouble.nvim",
	dependencies = "kyazdani42/nvim-web-devicons",
	opts = { auto_fold = true },
	keys = {
		{
			"gR",
			"<cmd>Trouble lsp_references<cr>",
			mode = "n",
			desc = "[g]o to LSP [R]eferences",
		},
	},
}
