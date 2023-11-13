local M = {}

-- checking directory (type)
function M.is_directory(path)
	local stat = vim.loop.fs_stat(path)
	return stat and stat.type == "directory" or false
end

-- handle runtime errors
function M.runtime_error(runtime_path)
	if type(runtime_path) == "string" then
		message = string.format("[RUNTIME ERROR] There is a problem loading the '%s' runtimepath. The desired path was not found or the desired directory does not exist.\n", (runtime_path))
		vim.notify(message, vim.log.levels.ERROR)
		vim.wait(5000, function() return false end)
		vim.cmd("cquit")
	end
end

return M
