-- session manager and fancy start screen
return {
	"mhinz/vim-startify",
	config = function()
		vim.g.startify_change_to_vcs_root = 1
		vim.g.startify_custom_header = "startify#center(startify#fortune#cowsay())"
		vim.g.startify_lists = {
			{ type = "sessions", header = { " Sessions" } },
			{ type = "dir", header = { " Directory Files" } },
			{ type = "files", header = { " Recent Files" } },
		}
	end,
}
