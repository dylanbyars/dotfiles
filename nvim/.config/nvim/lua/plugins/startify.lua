local g = vim.g

g.startify_change_to_vcs_root = 1
g.startify_custom_header = 'startify#center(startify#fortune#cowsay())'
g.startify_lists = {
  {type = 'sessions', header = {' Sessions'}},
  {type = 'dir', header = {' Directory Files'}},
  {type = 'files', header = {' Recent Files'}},
}

vim.api.nvim_command([[
function! GetUniqueSessionName()
  let path = fnamemodify(getcwd(), ':~:t')
  let path = empty(path) ? 'no-project' : path
  let branch = gitbranch#name()
  let branch = empty(branch) ? '' : '-' . branch
  return substitute(path . branch, '/', '-', 'g')
endfunction

autocmd VimLeavePre * silent execute 'SSave! ' . GetUniqueSessionName()
]])
