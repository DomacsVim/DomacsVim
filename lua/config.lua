local M = {}

-- return a table of default configs
function M.default_configs()
  return {
    keys = {
      leadermap = " ",
      term_mode = {},
      insert_mode = {},
      normal_mode = {},
      visual_mode = {},
      command_mode = {},
    },
    icons = require "icons",
    core = {},
    lazy = {},
    plugins = {},
    colorscheme = "onedark",
  }
end

-- load default configs
function M.load_default_configs()
  -- load lsp default configs
  dvim.lsp = vim.deepcopy(require("lsp.configs").defaults)

  local core = require "core"
  -- load default configs
  core.load_default_configs()

  local keymappings = require "keymappings"
  -- load the default keymappings
  keymappings.load_keymappings()
end

return M
