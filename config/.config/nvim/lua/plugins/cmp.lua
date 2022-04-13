--------------------------
-- cmp setup
--------------------------
vim.o.completeopt = "menuone,noselect"

local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	},
	sources = {
		{ name = "luasnip", keyword_length = 2 },
		{ name = "buffer", keyword_length = 6 },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "calc" },
		{ name = "nvim_lua" },
		-- { name = 'spell' },
	},
	documentation = {
		border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
	},
	experimental = {
		ghost_text = true,
	},
})

require("luasnip.loaders.from_vscode").lazy_load()
