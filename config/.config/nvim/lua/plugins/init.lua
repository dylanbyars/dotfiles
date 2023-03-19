return {
	-- colorscheme
	{ "folke/tokyonight.nvim", opts = { style = "night" } },

	--
	{ "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim", opts = {} },

	-- Add indentation guides even on blank lines
	{
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			char = "┊",
			show_trailing_blankline_indent = false,
		},
	},

	-- highlight hex strings with their color
	{ "norcalli/nvim-colorizer.lua", opts = {} },

	-- status line
	"nvim-lualine/lualine.nvim",

	-- breadcrumbs
	{ name = "nvim-gps", dir = "~/code/nvim-gps", dependencies = "nvim-treesitter/nvim-treesitter" },

	-- {
	-- 	"pwntester/octo.nvim",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-telescope/telescope.nvim",
	-- 		"kyazdani42/nvim-web-devicons",
	-- 	},
	-- 	opts = {},
	-- },

	{ "ruifm/gitlinker.nvim", dependencies = "nvim-lua/plenary.nvim", opts = {} },

	"tpope/vim-fugitive",

	-- git info in the signs column + status line
	{ "lewis6991/gitsigns.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

	-- commenting
	{ "numToStr/Comment.nvim", opts = {} },

	-- LSP Configuration & Plugins
	{
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
	},

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"L3MON4D3/LuaSnip", -- snippet engine
			-- completion sources
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
		},
	},

	{ "windwp/nvim-autopairs", opts = {} }, -- finsh the starting tag/symbol/thing

	-- Highlight, edit, and navigate code
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		opts = function()
			pcall(require("nvim-treesitter.install").update({ with_sync = true }))
		end,
	},

	{ "nvim-treesitter/playground", build = ":TSInstall query" },

	"windwp/nvim-ts-autotag", -- auto close and auto update closing tags

	"p00f/nvim-ts-rainbow", -- prettier () [] {}

	{ "johmsalas/text-case.nvim", opts = {} },

	-- search improvements
	{ "folke/trouble.nvim", dependencies = "kyazdani42/nvim-web-devicons", opts = { auto_fold = true } },

	-- filetree
	{ "kyazdani42/nvim-tree.lua", dependencies = { "kyazdani42/nvim-web-devicons" } },

	{ "kylechui/nvim-surround", opts = {} },

	"nvim-orgmode/orgmode",

	"is0n/fm-nvim",

	-- writing
	{ "folke/zen-mode.nvim", opts = {} },
}
