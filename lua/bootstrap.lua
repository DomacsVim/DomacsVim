local M = {}

local utils = require("utils.modules")
local log = require("utils.log")

function M.handle_user_config_file()
	local config_path = dvim_config_dir .. "/init.lua"
	local example_config = dvim_runtime_dir .. "/config.example.lua"

	local status_ok, err = pcall(dofile, config_path)

  if not status_ok then
  	if utils.is_file(config_path) then
			local message = "Invalid configuration: " .. err
  		vim.notify_once(message, vim.log.levels.WARN)
			log:WARN(message)
  	else
			local message = string.format("User-configuration not found. Creating an example configuration in %s", config_path)
  		vim.notify_once(message, vim.log.levels.WARN)
			log:WARN(message)
  		vim.fn.mkdir(dvim_config_dir, "p")
			log:TRACE("The configs directory was created.")
  		vim.loop.fs_copyfile(example_config, config_path)
			log:TRACE("The example config file was copied to the config directory.")
  	end
  end
end

return M
