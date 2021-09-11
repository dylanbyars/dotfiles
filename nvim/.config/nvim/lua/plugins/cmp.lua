--------------------------
-- cmp setup
--------------------------
vim.o.completeopt = 'menuone,noselect'

local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  },
  sources = {
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'calc' },
    { name = 'nvim_lua' },
    -- { name = 'spell' },
  },
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│", },
  },
})

