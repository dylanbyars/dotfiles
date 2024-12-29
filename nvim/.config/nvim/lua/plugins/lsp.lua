return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"SmiteshP/nvim-navic",
			"saghen/blink.cmp",
		},
		config = function()
			local navic = require("nvim-navic")

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
			end

			-- Setup mason so it can manage external tooling
			require("mason").setup()

			-- Enable the following language servers
			local servers = {
				"pyright",
				"ts_ls",
				"lua_ls",
				"html",
				"eslint",
				"bashls",
				"jsonls",
				"terraformls",
				"omnisharp",
				"gopls",
				"yamlls",
				"graphql",
        -- "docker"
				-- "docker-compose-langserver",
			}

			-- Ensure the servers above are installed
			require("mason-lspconfig").setup({ ensure_installed = servers })

			local function make_server_setup(server_name)
				local capabilities = require("blink.cmp").get_lsp_capabilities()

				local setup = {
					on_attach = on_attach,
					capabilities = capabilities,
				}

				if server_name == "ts_ls" then
					local function organize_imports()
						vim.lsp.buf.execute_command({
							command = "_typescript.organizeImports",
							arguments = { vim.api.nvim_buf_get_name(0) },
						})
					end

					setup.commands = {
						OrganizeImports = {
							organize_imports,
							description = "Organize Imports using `ts_ls`",
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
								version = "LuaJIT",
								path = runtime_path,
							},
							diagnostics = {
								globals = { "vim" },
							},
							workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
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
							},
						},
					}
				end

				if server_name == "bashls" then
					setup = {
						filetypes = { "sh", "zsh" },
					}
				end

				return setup
			end

			-- Setup all servers
			for _, server in ipairs(servers) do
				require("lspconfig")[server].setup(make_server_setup(server))
			end
		end,
	},
}
