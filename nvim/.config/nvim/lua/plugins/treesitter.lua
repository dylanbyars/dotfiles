local colors = require('colors')

require'nvim-treesitter.configs'.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
    'bash',
    'comment', -- highlight TODO and FIXME comments
    'css',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'lua',
    'regex',
    'scss',
    'toml',
    'tsx',
    'typescript',
    'yaml',
  },
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
    colors = function ()
      local c = {}
      for key, value in pairs(colors) do
        if key ~= 'foreground' and key ~= 'background' then
          table.insert(c, value)
        end
      end
      return c
    end
  },
  autotag = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      node_incremental = "o", -- out
      scope_incremental = "O", -- OUT!
      node_decremental = "i", -- in
    }
  },
  context_commentstring = { enable = true },
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}

require'treesitter-context.config'.setup{ enable = true }
