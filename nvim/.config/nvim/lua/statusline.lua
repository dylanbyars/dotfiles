require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = {'', ''},
    section_separators = {'', ''},
    disabled_filetypes = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      {'filename', path = 1} -- 0 = just filename, 1 = relative path, 2 = absolute path
    },
    lualine_c = {
      {
        'diff',
        colored = true, -- displays diff status in color if set to true
        -- all colors are in format #rrggbb
        color_added = COLORS.green, -- changes diff's added foreground color
        color_modified = COLORS.yellow, -- changes diff's modified foreground color
        color_removed = COLORS.red, -- changes diff's removed foreground color
        symbols = {added = '+', modified = '~', removed = '-'} -- changes diff symbols
      }
    },
    lualine_x = {
      -- TODO:
      -- 'diagnostics',
      --   sources = {'nvim_lsp'},
      --   -- displays diagnostics from defined severity
      --   sections = {'error', 'warn', 'info', 'hint'},
      --   -- all colors are in format #rrggbb
      --   color_error = nil, -- changes diagnostic's error foreground color
      --   color_warn = nil, -- changes diagnostic's warn foreground color
      --   color_info = nil, -- Changes diagnostic's info foreground color
      --   color_hint = nil, -- Changes diagnostic's hint foreground color
      --   symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'}
    },
    lualine_y = {'branch'},
    lualine_z = {'progress'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
