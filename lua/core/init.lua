local M = {}

-- a list of modules to load configurations
local modules = {
  autopairs = "core.autopairs",
  breadcrumbs = "core.breadcrumbs",
  bufferline = "core.bufferline",
  cmp = "core.cmp",
  dap = "core.dap",
  dashboard = "core.dashboard",
  gitsigns = "core.gitsigns",
  indentlines = "core.indentlines",
  lualine = "core.lualine",
  mason = "core.mason",
  nvimtree = "core.nvimtree",
  project = "core.project",
  telescope = "core.telescope",
  terminal = "core.terminal",
  treesitter = "core.treesitter",
  which_key = "core.whichkey",
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
