local M = {}

local log = require("utils.log")
local utils = require("utils.modules")
local plugins_dir = utils.join_paths(vim.fn.stdpath("cache"), "site", "pack", "lazy", "opt")
local lazy_dir = utils.join_paths(vim.fn.stdpath("cache"), "site", "pack", "lazy", "opt", "lazy.nvim")

function M.init()
  if not utils.is_directory(lazy_dir) then
    local initialize_message = "Initializing first time setup"
		print(initialize_message)
		log:TRACE(initialize_message)

		if not vim.loop.fs_stat(lazy_dir) then
      vim.fn.system {
        "git",
        "clone",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazy_dir,
      }
    end
  end

	vim.opt.rtp:prepend(lazy_dir)	

  pcall(function()
    -- set a custom path for lazy's cache
    local lazy_cache = require "lazy.core.cache"
    lazy_cache.path = utils.join_paths(vim.fn.stdpath("cache"), "lazy")
  end)
end

return M
