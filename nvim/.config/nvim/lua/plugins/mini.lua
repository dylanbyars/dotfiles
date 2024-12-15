return {
	"echasnovski/mini.nvim",
	version = "*",
	config = function()
		-- statusline
		local MiniStatusline = require("mini.statusline")

		local function custom_content()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			local progress = "%p%%" -- percentage through file
			local git_diff = MiniStatusline.section_diff({ trunc_width = 75 })
			local git = MiniStatusline.section_git({ trunc_width = 40 })

			-- Use full path with modified/readonly flags
			local filename = "%<%F%m%r"

			if git ~= "" then
				-- Match after the UTF-8 icon (3 bytes) and the space
				local branch = git:match("^...%s(.+)") -- ... matches any 3 bytes, %s matches space
				if branch and #branch > 20 then
					git = string.sub(git, 1, 4) .. branch:sub(1, 20) .. "..." -- Preserve the icon and space
				end
			end

			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { progress, filename } },
				"%=", -- Align right
				{ hl = "MiniStatuslineDevinfo", strings = { git_diff, git } },
			})
		end

		MiniStatusline.setup({
			content = {
				active = custom_content,
				inactive = MiniStatusline.default_content_inactive,
			},
			use_icons = true,
			set_vim_settings = true,
		})
	end,
}
