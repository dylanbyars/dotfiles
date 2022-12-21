local gitsigns = require("gitsigns")

gitsigns.setup({
	signs = {
		add = { text = "+" },
		change = { text = "~" },
		delete = { text = "_" },
		topdelete = { text = "‾" },
		changedelete = { text = "~" },
	},
})

vim.keymap.set("n", "[c", gitsigns.prev_hunk)
vim.keymap.set("n", "]c", gitsigns.next_hunk)
vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk)
vim.keymap.set("v", "<leader>hr", function()
	gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
end)
vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk)
vim.keymap.set("n", "<leader>hb", gitsigns.blame_line)