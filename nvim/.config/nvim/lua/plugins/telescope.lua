--------------------------
-- telescope
--------------------------
local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")

telescope.setup {
  defaults = {
    mappings = {
      i = { ["<c-q>"] = trouble.open_with_trouble },
      n = {
        ["<c-q>"] = trouble.open_with_trouble,
      },
    },
    dynamic_preview_title = true,
    path_display = {shorten = 3},
    layout_config = {
      height = 0.9,
      width = 0.9,
      horizontal = {
        preview_width = 0.7
      }
    }
  },
  extensions = {
    -- faster live_grep. I think. Should probably verify that...
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- "smart_case" (default) or "ignore_case" or "respect_case"
    }
  },
  pickers = {
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      mappings = {
        n = {
          -- right hand side can be the name of the action as string
          ["<bs>"] = "delete_buffer",
        }
      }
    },
    keymaps = {
      theme = "dropdown",
      previewer = false,
    },
  },
}

require('telescope').load_extension('fzf')
-- require('telescope').load_extension('neoclip')
