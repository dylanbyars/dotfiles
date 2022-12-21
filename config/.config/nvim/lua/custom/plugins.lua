-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	vim.cmd([[packadd packer.nvim]])
end

require("packer").startup({
	function(use)
		use("wbthomason/packer.nvim") -- Packer can manage itself
		-- colors
		use("folke/tokyonight.nvim") -- colorscheme
		use({
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("todo-comments").setup({})
			end,
		})

		use("lukas-reineke/indent-blankline.nvim") -- Add indentation guides even on blank lines

		use("norcalli/nvim-colorizer.lua") -- highlight hex strings with their color

		use("mhinz/vim-startify") -- session manager and fancy start screen

		-- status line
		use("nvim-lualine/lualine.nvim")

		use({ "~/code/nvim-gps", requires = "nvim-treesitter/nvim-treesitter" })

		-- git
		use({
			"pwntester/octo.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim",
				"kyazdani42/nvim-web-devicons",
			},
			config = function()
				require("octo").setup()
			end,
		})

		use({
			"ruifm/gitlinker.nvim",
			requires = "nvim-lua/plenary.nvim",
		})

		use("tpope/vim-fugitive")

		use({ -- git info in the signs column + status line
			"lewis6991/gitsigns.nvim",
			requires = { "nvim-lua/plenary.nvim" },
		})

		-- commenting
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})

		-- completion
		use({ -- LSP Configuration & Plugins
			"neovim/nvim-lspconfig",
			requires = {
				-- Automatically install LSPs to stdpath for neovim
				"williamboman/mason.nvim",
				"williamboman/mason-lspconfig.nvim",

				-- Useful status updates for LSP
				"j-hui/fidget.nvim",
			},
		})

		use({
			"hrsh7th/nvim-cmp",
			requires = {
				"L3MON4D3/LuaSnip", -- snippet engine
				-- completion sources
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
			},
		})

		use("windwp/nvim-autopairs") -- finsh the starting tag/symbol/thing

		-- treesitter
		use({ -- Additional text objects via treesitter
			"nvim-treesitter/nvim-treesitter-textobjects",
			after = "nvim-treesitter",
		})

		use({ -- Highlight, edit, and navigate code
			"nvim-treesitter/nvim-treesitter",
			run = function()
				pcall(require("nvim-treesitter.install").update({ with_sync = true }))
			end,
		})

		use({ "nvim-treesitter/playground", run = ":TSInstall query" })

		use("windwp/nvim-ts-autotag") -- auto close and auto update closing tags

		use("p00f/nvim-ts-rainbow") -- prettier () [] {}

		-- formatting
		use("sbdchd/neoformat")

		use({
			"johmsalas/text-case.nvim",
			config = function()
				require("textcase").setup({})
			end,
		})

		-- search improvements
		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("trouble").setup({
					auto_fold = true,
				})
			end,
		})

		-- telescope
		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			},
		})

		-- idk
		use({
			"kyazdani42/nvim-tree.lua",
			requires = {
				"kyazdani42/nvim-web-devicons", -- optional, for file icons
			},
			tag = "nightly", -- optional, updated every week. (see issue #1193)
		})

		use({
			"kylechui/nvim-surround",
			tag = "*", -- Use for stability; omit to use `main` branch for the latest features
			config = function()
				require("nvim-surround").setup({
					-- Configuration here, or leave empty to use defaults
				})
			end,
		})

		use({
			"simrat39/symbols-outline.nvim",
			config = function() end,
		})

		use("nvim-orgmode/orgmode")

		use("is0n/fm-nvim")

		-- writing
		use({
			"folke/zen-mode.nvim",
			config = function()
				require("zen-mode").setup({})
			end,
		})

		if is_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		-- show packer outputs in a floating window
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
	command = "source <afile> | PackerCompile",
	group = packer_group,
	pattern = vim.fn.expand("$MYVIMRC"),
})

require("colorizer").setup() -- must be called after plugin definitions

require("gitlinker").setup()

require("nvim-autopairs").setup({})

require("indent_blankline").setup({
	char = "┊",
	show_trailing_blankline_indent = false,
})

require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })

require("tokyonight").setup({
	-- use the night style
	style = "night",
})

vim.cmd("colorscheme tokyonight")
