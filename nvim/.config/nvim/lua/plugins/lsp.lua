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



--------------------------
-- LSP saga config
--------------------------
local saga = require 'lspsaga'
saga.init_lsp_saga {
  use_saga_diagnostic_sign = false,
  border_style = 'round',
  max_preview_lines = 15,
}


require('lsp_signature').setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  doc_lines = 2, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
  -- set to 0 if you DO NOT want any API comments be shown
  -- This setting only take effect in insert mode, it does not affect signature help in normal
  -- mode, 10 by default
  hint_enable = false, -- virtual hint enable
  floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
  fix_pos = false,  -- set to true, the floating window will not auto-close until finish all parameters
  use_lspsaga = true,  -- set to true if you want to use lspsaga popup
  hi_parameter = "Search", -- how your parameter will be highlight
  max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
  -- to view the hiding contents
  max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
  handler_opts = {
    border = "single"   -- double, single, shadow, none
  },
})
