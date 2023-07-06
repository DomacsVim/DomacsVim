local M = {}

local Log = require("core.log")

local modules = {
  nvimtree = "core.nvimtree",
  treesitter = "core.treesitter",
  autopairs = "core.autopairs",
  gitsigns = "core.gitsigns",
  telescope = "core.telescope"
}

function M.load()
  for module, path in pairs(modules) do
    local status_ok, config = xpcall(function() return require(path) end, function(err) print(err) end)
    if not status_ok then
      Log:ERROR("Failed to load '" .. module .. "' configs.")
      return
    end
    dvim.core[module] = config.configs()
  end
end

return M
