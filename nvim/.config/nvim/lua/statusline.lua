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
        -- bright green, yellow, and red from tokyonight
        color_added = '#9ece6a', -- changes diff's added foreground color
        color_modified = '#e0af68', -- changes diff's modified foreground color
        color_removed = '#f7768e', -- changes diff's removed foreground color
        symbols = {added = '+', modified = '~', removed = '-'} -- changes diff symbols
      }
    },
    lualine_x = {},
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
