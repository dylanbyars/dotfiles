-- git_diff_tabs.lua
local M = {}

M.git_diff_tabs = function()
	-- Get the current commit hash
	local current_commit = vim.fn.system("git rev-parse HEAD"):gsub("\n", "")

	-- Get the previous commit hash
	local previous_commit = vim.fn.system("git rev-parse HEAD~1"):gsub("\n", "")

	-- Get the list of changed files between the current and previous commit
	local changed_files = vim.fn.systemlist("git diff --name-only " .. previous_commit .. " " .. current_commit)

	-- Open each changed file in a new tab and run :Gdiff
	for _, file in ipairs(changed_files) do
		vim.cmd("tabedit " .. file)
		vim.cmd("Gdiff " .. previous_commit)
	end
end

return M
