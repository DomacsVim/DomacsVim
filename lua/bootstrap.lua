local M = {}

local log = require "utils.log"
local utils = require "utils.modules"
_G.plugins_dir = utils.join_paths(vim.fn.stdpath "cache", "site", "pack", "lazy", "opt")
_G.lazy_dir = utils.join_paths(vim.fn.stdpath "cache", "site", "pack", "lazy", "opt", "lazy.nvim")

local default_configs = require("config").default_configs()
dvim = vim.tbl_extend("force", default_configs, dvim)

function M.handle_user_config_file()
  local config_path = utils.join_paths(dvim_config_dir, "init.lua")
  local example_config = utils.join_paths(dvim_runtime_dir, "config.example.lua")

  local status_ok, err = pcall(dofile, config_path)

  if not status_ok then
    if utils.is_file(config_path) then
      local message = "Invalid configuration: " .. err
      vim.notify_once(message, vim.log.levels.WARN)
      log:WARN(message)
    else
      local message =
        string.format("User-configuration not found. Creating an example configuration in %s", config_path)
      vim.notify_once(message, vim.log.levels.WARN)
      log:WARN(message)
      ---@diagnostic disable-next-line: param-type-mismatch
      vim.fn.mkdir(dvim_config_dir, "p")
      log:TRACE "The configs directory was created."
      vim.loop.fs_copyfile(example_config, config_path)
      log:TRACE "The example config file was copied to the config directory."
    end
  else
    log:INFO "The configuration file has been loaded successfully."
  end
end

function M.initialize_plugin_manager()
  if not utils.is_directory(_G.lazy_dir) then
    local initialize_message = "Initializing first time setup"
    print(initialize_message)
    log:TRACE(initialize_message)

    if not vim.loop.fs_stat(_G.lazy_dir) then
      vim.fn.system {
        "git",
        "clone",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        _G.lazy_dir,
      }
    end
  end

  vim.opt.rtp:prepend(_G.lazy_dir)

  pcall(function()
    -- set a custom path for lazy's cache
    local lazy_cache = require "lazy.core.cache"
    lazy_cache.path = utils.join_paths(vim.fn.stdpath "cache", "lazy")
  end)
end

return M
