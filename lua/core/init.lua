local M = {}

-- a list of modules to load configurations
local modules = {
  autopairs = "core.autopairs",
  comment = "core.comment",
  nvimtree = "core.nvimtree",
  treesitter = "core.treesitter",
  gitsigns = "core.gitsigns",
  telescope = "core.telescope",
  project = "core.project",
  indentlines = "core.indentlines",
  terminal = "core.terminal"
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
