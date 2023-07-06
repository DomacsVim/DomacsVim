local M = {}

local Log = require("core.log")

local modules = {
  nvimtree = "core.nvimtree",
  treesitter = "core.treesitter",
  autopairs = "core.autopairs",
}

function M.load()
  for module, path in pairs(modules) do
    local status_ok, config = xpcall(function() return require(path) end, function(err) print(err) end)
    if not status_ok then
      Log:ERROR("Failed to load '" .. module .. "' configs.")
      return
    end
    dvim.core[module] = config.configs()
    config.setup()
  end
end

return M
