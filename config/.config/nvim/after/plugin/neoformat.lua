vim.g.neoformat_only_msg_on_error = 1
vim.g.neoformat_try_node_exe = 1 -- node projects with a `prettier` dependency will use the bin in `$PROJECT/node_modules/.bin`
vim.g.shfmt_opt = "-ci" -- make `shfmt` work nicely with neovim

vim.keymap.set("n", "<leader>f", vim.cmd("Neoformat"))
