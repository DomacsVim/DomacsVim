local M = {}

-- check the neovim version
if vim.fn.has("nvim-0.9") ~= 1 then
  vim.notify("Please upgrade your Neovim base installation. Domacsvim requires v0.9+", vim.log.levels.WARN)
  log:ERROR("Please upgrade your Neovim base installation. Domacsvim requires v0.9+")
  vim.wait(4000, function()
    return false
  end)
  vim.cmd("cquit")
end

-- get the domacsvim cache directory
_G.dvim_cache_dir = vim.env.DVIM_CACHE_DIR
-- get the domacsvim config directory
_G.dvim_config_dir = vim.env.DVIM_CONFIG_DIR

function M.init()
  if dvim_runtime_dir then
    vim.opt.rtp:remove(vim.call("stdpath", "config"))
    vim.opt.rtp:remove(vim.call("stdpath", "config") .. "/after")
    vim.opt.rtp:remove("$HOEM/.local/share/nvim/site")
    vim.opt.rtp:remove("$HOEM/.local/share/nvim/site/after")
    vim.opt.rtp:remove(vim.call("stdpath", "data") .. "/site")

    vim.opt.rtp:append(dvim_runtime_dir .. "/site")
    vim.opt.rtp:append(dvim_runtime_dir .. "/site" .. "/after")
    vim.opt.rtp:append(dvim_config_dir)
    vim.opt.rtp:append(dvim_config_dir .. "/after")
    vim.opt.rtp:append(dvim_config_dir .. "/init.lua")

    vim.opt.packpath = vim.opt.rtp:get()
  end
  vim.fn.stdpath = function(what)
    if what == "data" then
      return dvim_runtime_dir .. "/site"
    elseif what == "config" then
      return dvim_config_dir
    elseif what == "cache" then
      return dvim_cache_dir
    end
    return vim.call("stdpath", what)
  end
end

return M
