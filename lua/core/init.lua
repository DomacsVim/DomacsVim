local M = {}

-- a list of modules to load configurations
local modules = {
  nvimtree = "core.nvimtree",
  treesitter = "core.treesitter",
  gitsigns = "core.gitsigns",
  telescope = "core.telescope",
}

function M.load_default_configs()
  for name, path in pairs(modules) do
    dvim.core[name] = require(path).defaults
    if dvim.core[name].keymappings then
      for mode, modes in pairs(dvim.core[name].keymappings) do
        for key, val in pairs(modes) do
          dvim.keys[mode][key] = val
        end
      end
    end
  end
end

return M
