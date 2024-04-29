-- check the neovim version
if vim.fn.has("nvim-0.9") ~= 1 then
  vim.notify("Please upgrade your Neovim base installation. Domacsvim requires v0.9+", vim.log.levels.WARN)
  vim.wait(4000, function() return false end)
  vim.cmd("cquit")
end

-- get and set the domacsvim runtimepath
_G.dvim_runtime_dir = os.getenv("DVIM_RUNTIME_DIR") or debug.getinfo(1, "S").source:sub(2):match("(.*[/\\])"):sub(1, -2)
if not vim.tbl_contains(vim.opt.rtp:get(), dvim_runtime_dir) then
  vim.opt.rtp:prepend(dvim_runtime_dir)
end

local utils = require("utils.modules")

-- get the domacsvim config directory
_G.dvim_config_dir = os.getenv("DVIM_CONFIG_DIR")
if dvim_config_dir then
  if not utils.is_directory(dvim_config_dir) then
    vim.fn.mkdir(dvim_config_dir)
  end
else
	local message = string.format("dvim_config_dir : %s", (dvim_config_dir))
	utils.runtime_error(message)
end

-- get the domacsvim cache directory
_G.dvim_cache_dir = os.getenv("DVIM_CACHE_DIR")
if dvim_cache_dir then
	if not utils.is_directory(dvim_cache_dir) then
		vim.fn.mkdir(dvim_cache_dir)
	end
else
	local message = string.format("dvim_cache_dir : %s", (dvim_cache_dir))
	utils.runtime_error(message)
end

-- remove neovim base runtime paths and add domacsvim runtime paths
vim.opt.rtp:remove(vim.call("stdpath", "data"))
vim.opt.rtp:remove(vim.call("stdpath", "cache"))
vim.opt.rtp:remove(vim.call("stdpath", "config"))
vim.opt.rtp:remove(utils.join_paths(vim.call("stdpath", "data"), "site"))
vim.opt.rtp:remove(utils.join_paths(vim.call("stdpath", "config"), "after"))
vim.opt.rtp:remove(utils.join_paths(vim.call("stdpath", "data"), "site", "after"))
vim.opt.rtp:append(dvim_cache_dir)
vim.opt.rtp:append(dvim_config_dir)
vim.opt.rtp:append(utils.join_paths(dvim_config_dir, "after"))
vim.opt.rtp:append(utils.join_paths(dvim_cache_dir, "database"))
vim.opt.rtp:append(utils.join_paths(dvim_cache_dir, "database", "after"))

vim.opt.packpath = vim.opt.rtp:get()

vim.fn.stdpath = function(what)
	if what == "data" then
		return utils.join_paths(dvim_cache_dir, "database")
	elseif what == "config" then
		return dvim_config_dir
	elseif what == "cache" then
		return dvim_cache_dir
	end
	return vim.call("stdpath", what)
end

-- disable extra providers
for _, provider in ipairs({ "node", "perl", "python3", "ruby" }) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- load defautl options
require("options")

-- dvim global variable
dvim = {}

local bootstrap = require("bootstrap")

-- initialize user config file.
bootstrap.handle_user_config_file()

-- initialize plugin manager
bootstrap.initialize_plugin_manager()

local config = require("config")

-- load dvim default configuration
config.load_default_configs()

local plugin_manager = require("plugin-manager")

-- load the default plugins
plugin_manager.setup()
