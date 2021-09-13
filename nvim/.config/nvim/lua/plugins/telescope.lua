--------------------------
-- telescope
--------------------------
local trouble = require("trouble.providers.telescope")
local telescope = require("telescope")
local actions = require('telescope.actions')

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<C-c>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ["<C-k>"] = actions.preview_scrolling_up,
        ["<C-j>"] = actions.preview_scrolling_down,
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = trouble.open_with_trouble,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
        ["<C-n>"] = false,
        ["<C-p>"] = false,
        ["<Down>"] = false,
        ["<Up>"] = false,
        ["<M-q>"] = false,
        ["<C-l>"] = false,
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,
        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = trouble.open_with_trouble,
        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,
        ["K"] = actions.preview_scrolling_up,
        ["J"] = actions.preview_scrolling_down,
        ["?"] = actions.which_key,
        ["<M-q>"] = false,
        ["<Down>"] = false,
        ["<Up>"] = false,
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
