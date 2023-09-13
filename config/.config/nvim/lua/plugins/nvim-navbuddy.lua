return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"SmiteshP/nvim-navbuddy",
			dependencies = {
				"SmiteshP/nvim-navic",
				"MunifTanjim/nui.nvim",
			},
			opts = {
				lsp = { auto_attach = true },
				window = {
					-- border = "single", -- "rounded", "double", "solid", "none"
					-- or an array with eight chars building up the border in a clockwise fashion
					-- starting with the top-left corner. eg: { "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" }.
					size = {height = "95%", width = "50%"}, -- Or table format example: { height = "40%", width = "100%"}
					position = {row = "0%", col = "100%"}, -- Or table format example: { row = "100%", col = "0%"}
					scrolloff = 4, -- scrolloff value within navbuddy window
					sections = {
						left = {
							size = "20%",
							-- border = nil, -- You can set border style for each section individually as well.
						},
						mid = {
							size = "60%",
							-- border = nil,
						},
						right = {
							-- No size option for right most section. It fills to
							-- remaining area.
							-- border = nil,
							preview = "never", -- Right section can show previews too.
							-- Options: "leaf", "always" or "never"
						},
					},
				},
			},
		},
	},
}
