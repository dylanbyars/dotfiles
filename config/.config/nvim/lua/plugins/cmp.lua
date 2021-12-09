--------------------------
-- cmp setup
--------------------------
vim.o.completeopt = "menuone,noselect"

local cmp = require("cmp")

local lspkind = require("lspkind")

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
		{ name = "luasnip" },
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

	formatting = {
		format = lspkind.cmp_format({
			with_text = true, -- do not show text alongside icons
			maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
		}),
	},
})

require("luasnip/loaders/from_vscode").load() -- loads snippets provided by `friendly-snippets` into luasnip
