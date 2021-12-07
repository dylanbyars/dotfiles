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
		use({ "SmiteshP/nvim-gps", requires = "nvim-treesitter/nvim-treesitter" })
		-- git
		use("tpope/vim-fugitive") -- ya it's pretty good
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
		use("L3MON4D3/LuaSnip") -- cmp requires a snippet engine
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				-- completion sources
				"saadparwaiz1/cmp_luasnip",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-nvim-lua",
				"hrsh7th/cmp-calc",
				"f3fora/cmp-spell",
				"hrsh7th/cmp-nvim-lsp",
			},
		})
		use("windwp/nvim-autopairs") -- finsh the starting tag/symbol/thing
		use("RRethy/vim-illuminate") -- highlight other instances of the focused word
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
		use("simrat39/symbols-outline.nvim") -- pretty good for file local symbols
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

vim.api.nvim_exec(
	[[
  augroup Packer
    autocmd!
    autocmd BufWritePost */plugins/init.lua PackerCompile
  augroup end
]],
	false
)

require("plugins.treesitter")

require("colorizer").setup()

require("gitsigns").setup({
	keymaps = {
		["n ]c"] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns\".next_hunk({wrap = true})<CR>'" },
		["n [c"] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns\".prev_hunk({wrap = true})<CR>'" },
		["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
		["v <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
		["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
		["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
		["v <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
		["n <leader>hR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
		["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
		["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
		["n <leader>hS"] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
		["n <leader>hU"] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',
	},
})

require("plugins.telescope")

require("plugins.lsp")

require("plugins.cmp")

-- nvim-autopairs stuff has to go after cmp setup
require("nvim-autopairs").setup({})

require("plugins.lualine")

require("plugins.startify")

require("fm-nvim").setup({
	-- Floating window border (see ":h nvim_open_win")
	border = "double",

	-- Highlight group for floating window/border (see ":h winhl")
	border_hl = "FloatBorder",
	float_hl = "Normal",

	-- Num from `0 - 1` for measurements
	height = 0.9,
	width = 0.6,

	-- (Vim) Command used to open files
	edit_cmd = "edit", -- opts: 'tabedit', 'split', 'pedit', etc...
})
