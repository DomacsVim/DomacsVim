local M = {}

local utils = require("utils")
local config_path = dvim_config_dir .. "/init.lua"
local example_config = dvim_runtime_dir .. "/config.example.lua"

-- handle user configuration file.
function M.init()
	local ok, err = pcall(dofile, config_path)
	if not ok then
		if utils.is_file(config_path) then
			vim.notify_once("Invalid configuration: " .. err, vim.log.levels.WARN)
		else
			vim.notify_once(
				string.format("User-configuration not found. Creating an example configuration in %s", config_path)
			)
			vim.fn.mkdir(dvim_config_dir, "p")
			vim.loop.fs_copyfile(example_config, config_path)
		end
	end
end

function M.load()
	dvim = vim.deepcopy(require("config.defaults"))

	-- import default options
	require("options").load()
end

return M
