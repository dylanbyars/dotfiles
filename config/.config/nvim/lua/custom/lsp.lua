--------------------------
-- LSP config
--------------------------
-- servers installed:
-- typescript
-- html
-- css
-- lua
-- dockerfile
-- bash
-- yaml
-- vim

-- local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
-- lsp_installer.on_server_ready(function(server)
-- 	local opts = {}
--
-- 	if server.name == "tsserver" then
-- 		local function organize_imports()
-- 			vim.lsp.buf.execute_command({
-- 				command = "_typescript.organizeImports",
-- 				arguments = { vim.api.nvim_buf_get_name(0) },
-- 			})
-- 		end
--
-- 		opts = {
-- 			commands = {
-- 				OrganizeImports = {
-- 					organize_imports,
-- 					description = "Organize Imports",
-- 				},
-- 			},
-- 		}
-- 	end
--
-- 	if server.name == "pyright" then
-- 		local function organize_imports()
-- 			vim.lsp.buf.execute_command({
-- 				command = "_typescript.organizeImports",
-- 				arguments = { vim.api.nvim_buf_get_name(0) },
-- 			})
-- 		end
--
-- 		opts = {
-- 			commands = {
-- 				OrganizeImports = {
-- 					organize_imports,
-- 					description = "Organize Imports",
-- 				},
-- 			},
-- 		}
-- 	end
--
-- 	--     -- make lua language server aware of a global variable called `vim`
-- 	if server.name == "sumneko_lua" then
-- 		opts = {
-- 			settings = {
-- 				Lua = {
-- 					diagnostics = {
-- 						-- Get the language server to recognize the `vim` global
-- 						globals = { "vim" },
-- 					},
-- 					workspace = {
-- 						-- Make the server aware of Neovim runtime files
-- 						library = {
-- 							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
-- 							[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
-- 						},
-- 					},
-- 				},
-- 			},
-- 		}
-- 	end
--
-- 	-- This setup() function is exactly the same as lspconfig's setup function.
-- 	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- 	server:setup(opts)
-- end)

-- LSP settings.

-- This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	nmap("<leader>r", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

	nmap("<leader>d", function()
		vim.cmd("split")
		vim.lsp.buf.definition()
	end, "[d]efinition (open in a split)")

	nmap("<leader>D", vim.lsp.buf.definition, "[D]efinition (open in current buffer)")

	nmap("<leader>ld", function()
		vim.diagnostic.open_float({ border = "rounded" })
	end, "[L]ine [D]iagnostics")

	nmap("[e", function()
		vim.diagnostic.goto_prev({ float = false })
	end, "Previous [e]rror")

	nmap("]e", function()
		vim.diagnostic.goto_next({ float = false })
	end, "Next [e]rror")

	-- style the floating windows
	local borderStyle = { border = "double", max_width = 90 }
	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, borderStyle)
	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, borderStyle)
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics,
		{ underline = false }
	)
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	vim.keymap.set(
		{ "n", "i" },
		"<C-k>",
		vim.lsp.buf.signature_help,
		{ buffer = bufnr, desc = "Signature Documentation" }
	)

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
-- what are these? -> "css", "dockerfile", "bash", "yaml", "vim"
local servers = { "pyright", "tsserver", "sumneko_lua", "html" }

-- Ensure the servers above are installed
require("mason-lspconfig").setup({
	ensure_installed = servers,
})

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities) -- the plugin is hyphen cased but this is referenced as snake case. why?

for _, lsp in ipairs(servers) do
	require("lspconfig")[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- Turn on lsp status information
require("fidget").setup()

-- Example custom configuration for lua
--
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig").sumneko_lua.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
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
	},
})
