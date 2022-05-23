local gps = require("nvim-gps")
gps.setup()

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "tokyonight",
		component_separators = "",
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "TelescopePrompt" },
	},
	sections = {
		lualine_a = {
			{
				"mode",
				fmt = function(str)
					return str:sub(1, 1)
				end,
				separator = { left = "", right = ""  },
			},
		},
		lualine_b = { { gps.get_location, condition = gps.is_available, padding = 2 } },
		lualine_c = {},
		lualine_x = {},
		lualine_y = {
			{ "diff", diff_color = { removed = { fg = "red" } } },
			{ "branch", separator = { right = "" } },
		},
		lualine_z = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	-- tabline = {
	-- 	lualine_a = { {'tabs', mode = 1, max_length = vim.o.columns} },
	-- 	lualine_b = {},
	-- 	lualine_c = {},
	-- 	lualine_x = {},
	-- 	lualine_y = {},
	-- 	lualine_z = {},
	-- },
	extensions = {},
})

-- local filename = require("tabby.filename")
local util = require("tabby.util")

local hl_tabline = util.extract_nvim_hl("TabLine")
local hl_normal = util.extract_nvim_hl("Normal")
local hl_tabline_sel = util.extract_nvim_hl("TabLineSel")
local hl_tabline_fill = util.extract_nvim_hl("TabLineFill")

local function tab_label(tabid, active)
	-- local icon = active and "" or ""
	local name = util.get_tab_name(tabid)
	-- return string.format(" %s %s ", icon, name)
	return string.format(" %s ", name)
end

local tabline = {
	hl = "TabLineFill",
	layout = "tab_only",
	-- head = {
	-- 	{ "  ", hl = { fg = hl_tabline.fg, bg = hl_tabline.bg } },
	-- 	{ "", hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
	-- },
	-- tail = {
	-- TODO: put git stuff up here
	-- 	{ require('gitsigns'), hl = { fg = hl_tabline.fg, bg = hl_tabline.bg } },
	-- 	{ "", hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
	-- },
	active_tab = {
		label = function(tabid)
			return {
				tab_label(tabid, true),
				hl = { fg = hl_tabline_sel.fg, bg = hl_tabline_sel.bg, style = "bold" },
			}
		end,
		left_sep = { "", hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
		right_sep = { "", hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
	},
	inactive_tab = {
		label = function(tabid)
			return {
				tab_label(tabid, false),
				hl = { fg = hl_tabline.fg, bg = hl_tabline.bg, style = "bold" },
			}
		end,
		left_sep = { "", hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
		right_sep = { "", hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
	},
}

require("tabby").setup({
	tabline = tabline,
	opt = {
		show_at_least = 2,
	},
})
