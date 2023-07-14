local M = {}

local utils = require("utils")

-- check the neovim version
if vim.fn.has("nvim-0.9") ~= 1 then
  vim.notify("Please upgrade your Neovim base installation. Domacsvim requires v0.9+", vim.log.levels.WARN)
  vim.wait(4000, function()
    return false
  end)
  vim.cmd("cquit")
end

-- get the domacsvim cache directory
_G.dvim_cache_dir = vim.env.DVIM_CACHE_DIR
if not utils.is_directory(dvim_cache_dir) then
  vim.fn.mkdir(dvim_cache_dir)
end
-- get the domacsvim config directory
_G.dvim_config_dir = vim.env.DVIM_CONFIG_DIR
if not utils.is_directory(dvim_config_dir) then
  vim.fn.mkdir(dvim_config_dir)
end

function M.init()
  -- remove neovim and set domacsvim runtimepaths
  if dvim_runtime_dir then
    vim.opt.rtp:remove(vim.call("stdpath", "config"))
    vim.opt.rtp:remove(vim.call("stdpath", "config") .. "/after")
    vim.opt.rtp:remove("$HOEM/.local/share/nvim/site")
    vim.opt.rtp:remove("$HOEM/.local/share/nvim/site/after")
    vim.opt.rtp:remove(vim.call("stdpath", "data") .. "/site")

    vim.opt.rtp:append(dvim_runtime_dir .. "/database")
    vim.opt.rtp:append(dvim_runtime_dir .. "/database" .. "/after")
    vim.opt.rtp:append(dvim_config_dir)
    vim.opt.rtp:append(dvim_config_dir .. "/after")

    vim.opt.packpath = vim.opt.rtp:get()
  end
  -- change standard paths
  vim.fn.stdpath = function(what)
    if what == "data" then
      return dvim_runtime_dir .. "/database"
    elseif what == "config" then
      return dvim_config_dir
    elseif what == "cache" then
      return dvim_cache_dir
    end
    return vim.call("stdpath", what)
  end
  -- disable extra providers
  for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
    vim.g["loaded_" .. provider .. "_provider"] = 0
  end
  -- setup dvim configs
  require("config").load()
  -- setup plugins
  require("plugins.manager").setup()
end

return M
