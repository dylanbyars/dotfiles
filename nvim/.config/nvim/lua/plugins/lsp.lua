--------------------------
-- LSP config
--------------------------
-- TODO: there's gotta be a better way to record what servers a person's installed...
-- servers installed:
-- typescript
-- html
-- css
-- lua
-- dockerfile
-- bash
-- yaml
-- vim
local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    local config = {
      on_attach = function(client)
        require 'illuminate'.on_attach(client)
      end,
    }

    if server == 'typescript' then

      local function organize_imports()
        vim.lsp.buf.execute_command({
          command = "_typescript.organizeImports",
          arguments = {vim.api.nvim_buf_get_name(0)},
        })
      end

      config = {
        commands = {
          OrganizeImports = {
            organize_imports,
            description = "Organize Imports"
          }
        }
      }
    end

    -- make lua language server aware of a global variable called `vim`
    if server == 'lua' then
      config = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      }
    end

    require'lspconfig'[server].setup(config)
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

