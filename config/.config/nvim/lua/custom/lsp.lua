local navic = require("nvim-navic")
local navbuddy = require("nvim-navbuddy")

-- This function gets run when an LSP connects to a particular buffer.
local on_attach = function(server, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>r", vim.lsp.buf.rename, "[r]ename")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[c]ode [a]ction")

	nmap("<leader><leader>d", function()
		vim.cmd("split")
		vim.lsp.buf.definition()
	end, "[d]efinition (open in a split)")

	nmap("<leader>d", vim.lsp.buf.definition, "[D]efinition (open in current buffer)")

	nmap("<leader>ld", function()
		vim.diagnostic.open_float({ border = "rounded" })
	end, "[l]ine [d]iagnostics")

	nmap("[e", function()
		vim.diagnostic.goto_prev({ float = false })
	end, "Previous [e]rror")

	nmap("]e", function()
		vim.diagnostic.goto_next({ float = false })
	end, "Next [e]rror")

	nmap("<leader>f", vim.lsp.buf.format, "[f]ormat buffer")

	-- style the floating windows
	local borderStyle = { border = "double", max_width = 90 }
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, borderStyle)
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, borderStyle)
	vim.lsp.handlers["textDocument/publishDiagnostics"] =
		vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { underline = false })
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	vim.keymap.set(
		{ "n", "i" },
		"<C-k>",
		vim.lsp.buf.signature_help,
		{ buffer = bufnr, desc = "Signature Documentation" }
	)

	local function organize_imports(command)
		nmap("<leader>o", function()
			vim.cmd(command)
		end, "[o]rganize imports and auto fix linty problems")
	end

	if server.name == "eslint" then
		organize_imports("EslintFixAll")
	end

	if server.name == "pyright" then
		organize_imports("PyrightOrganizeImports")
	end

	if server.server_capabilities.documentSymbolProvider then
		navic.attach(server, bufnr)
	end

	navbuddy.attach(server, bufnr)

	-- Create a command `:Format` local to the LSP buffer
	-- vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
	-- 	if vim.lsp.buf.format then
	-- 		vim.lsp.buf.format()
	-- 	elseif vim.lsp.buf.formatting then
	-- 		vim.lsp.buf.formatting()
	-- 	end
	-- end, { desc = "Format current buffer with LSP" })
end

-- Setup mason so it can manage external tooling
require("mason").setup()

-- Enable the following language servers
local servers = { "pyright", "tsserver", "lua_ls", "html", "eslint", "bashls", "jsonls", "terraformls" }

-- Ensure the servers above are installed
require("mason-lspconfig").setup({
	ensure_installed = servers,
})

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities) -- the plugin is hyphen cased but this is referenced as snake case. why?

local function make_server_setup(server_name)
	local setup = {
		on_attach = on_attach,
		capabilities = capabilities,
	}

	if server_name == "tsserver" then
		local function organize_imports()
			vim.lsp.buf.execute_command({
				command = "_typescript.organizeImports",
				arguments = { vim.api.nvim_buf_get_name(0) },
			})
		end

		setup.commands = {
			OrganizeImports = {
				organize_imports,
				description = "Organize Imports using `tsserver`",
			},
		}
	end

	if server_name == "lua_ls" then
		-- Make runtime files discoverable to the server
		local runtime_path = vim.split(package.path, ";")
		table.insert(runtime_path, "lua/?.lua")
		table.insert(runtime_path, "lua/?/init.lua")

		setup.settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT)
					version = "LuaJIT",
					-- Setup your lua path
					path = runtime_path,
				},
				diagnostics = {
					globals = { "vim" },
				},
				workspace = { library = vim.api.nvim_get_runtime_file("", true) },
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = { enable = false },
			},
		}
	end

	if server_name == "pyright" then
		setup.settings = {
			python = {
				analysis = {
					autoSearchPaths = true,
					useLibraryCodeForTypes = true,
					-- diagnosticMode = 'workspace',
					-- typeCheckingMode = 'basic',
				},
			},
		}
	end

	return setup
end

-- more details on the `setup` function https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
for _, server in ipairs(servers) do
	require("lspconfig")[server].setup(make_server_setup(server))
end

local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
-- TODO: write a function that sets this up dynamically based on the project vim is opened in. Sometimes I want prettier, other times dprint
null_ls.setup({
	sources = {
		formatting.dprint,
		-- formatting.prettierd,
		formatting.black,
		formatting.stylua,
	},
})
require("mason-null-ls").setup({
	ensure_installed = nil,
	automatic_installation = true,
	automatic_setup = false,
})

-- Turn on lsp status information
require("fidget").setup()
