local g, api, fn = vim.g, vim.api, vim.fn

g.startify_change_to_vcs_root = 1
g.startify_custom_header = 'startify#center(startify#fortune#cowsay())'
g.startify_lists = {
  {type = 'sessions', header = {' Sessions'}},
  {type = 'dir', header = {' Directory Files'}},
  {type = 'files', header = {' Recent Files'}},
}

-- function _G.SaveSession()
--   -- :~ -> cwd relative to home dir
--   -- :t -> tail of the path (which should be the VCS root dir name)
--   local path = fn.fnamemodify(fn.getcwd(), ':~:t')
--   path = #path > 0 and path or 'no-project'
--   local branch = fn.system('git rev-parse --abbrev-ref head 2> /dev/null') -- don't shout if it fails
--   branch = #branch > 0 and branch or ''
--   local sessionName = string.gsub(path..' -> '..branch, '/', '-')

--   return api.nvim_command('SSave! '..sessionName)
-- end

-- api.nvim_command("autocmd VimLeavePre * silent lua SaveSession()")

