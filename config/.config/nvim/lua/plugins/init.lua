-- Install packer
local execute = vim.api.nvim_command
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.cmd([[packadd packer.nvim]]) -- see this line in a lot of setup packer automatically snippets. why?
require("packer").startup({
	function(use)
		use("wbthomason/packer.nvim") -- Packer can manage itself
		-- colors
		use("folke/tokyonight.nvim") -- colorscheme
		use("norcalli/nvim-colorizer.lua") -- highlight hex strings with their color
		use("mhinz/vim-startify") -- session manager and fancy start screen
		-- status line
		use("hoob3rt/lualine.nvim")
		use({ "~/code/nvim-gps", requires = "nvim-treesitter/nvim-treesitter" })
		-- git
		use("tpope/vim-fugitive")
		use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } }) -- git info in the signs column + status line
		-- commenting
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})
		-- completion
		use("neovim/nvim-lspconfig") -- configure lsp
		use("williamboman/nvim-lsp-installer") -- for installing language servers
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				-- completion sources
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-nvim-lsp",
			},
		})
		use("L3MON4D3/LuaSnip") -- snippet engine
		use("windwp/nvim-autopairs") -- finsh the starting tag/symbol/thing
		-- treesitter
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
		use({ "nvim-treesitter/playground", run = ":TSInstall query" })
		use("windwp/nvim-ts-autotag") -- auto close and auto update closing tags
		use("p00f/nvim-ts-rainbow") -- prettier () [] {}
		-- formatting
		use("sbdchd/neoformat")
		-- search improvements
		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("trouble").setup({})
			end,
		})
		use("wincent/loupe") -- search highlight improved. TODO: feels like I can do this myself
		-- telescope
		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				{ "nvim-lua/popup.nvim" },
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			},
		})
		-- idk
		use("tpope/vim-surround")
		use("vimwiki/vimwiki")
		use("is0n/fm-nvim")
		-- writing
		use("junegunn/goyo.vim")
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

-- still not sure if this works...
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	pattern = { "*/plugins/init.lua" },
	command = "PackerCompile",
})

require("plugins.treesitter")

require("colorizer").setup() -- must be called after plugin definitions

require("gitsigns").setup()

require("plugins.telescope")

require("plugins.lsp")

require("plugins.cmp")

-- nvim-autopairs stuff has to go after cmp setup
require("nvim-autopairs").setup({})

require("plugins.statusline")

require("fm-nvim").setup({
	-- (Vim) Command used to open files
	edit_cmd = "edit",
	-- See `Q&A` for more info
	on_close = {},
	on_open = {},
	-- Commands
	cmds = { broot_cmd = "broot -h" },
	-- UI Options
	ui = {
		-- Default UI (can be "split" or "float")
		default = "float",
		float = {
			-- Floating window border (see ':h nvim_open_win')
			border = "rounded",
			-- Highlight group for floating window/border (see ':h winhl')
			float_hl = "Normal",
			border_hl = "FloatBorder",
			-- Floating Window Transparency (see ':h winblend')
			blend = 0,
			-- Num from 0 - 1 for measurements
			height = 1,
			width = 0.85,
			-- X and Y Axis of Window
			x = 0,
			y = 0,
		},
	},

	broot_conf = "~/.config/broot/nvim_broot_conf.hjson",
})


require("luasnip.loaders.from_vscode").lazy_load({ paths = {"~/.config/nvim/lua/plugins/snippets" }})
