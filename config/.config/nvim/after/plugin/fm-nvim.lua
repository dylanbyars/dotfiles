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
			width = 1,
			-- X and Y Axis of Window
			x = 0,
			y = 0,
		},
	},

	broot_conf = "~/.config/broot/nvim_broot_conf.hjson",
})
