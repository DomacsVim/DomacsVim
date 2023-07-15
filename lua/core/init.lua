local M = {}

local modules = {
  "core.autopairs",
  "core.dashboard",
  "core.gitsigns",
  "core.nvimtree",
  "core.telescope",
  "core.terminal",
  "core.treesitter",
  "core.whichkey"
}

function M.load()
  for _, k in pairs(modules) do
    xpcall(function()
      require(k).config()
    end, function() return end)
  end
end

return M
