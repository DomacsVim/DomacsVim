local M = {}

local modules = {
  "core.autopairs",
  "core.dashboard",
  "core.gitsigns",
  "core.nvimtree",
  "core.telescope",
  "core.terminal",
  "core.treesitter",
  "core.whichkey",
  "core.mason",
  "core.cmp",
  "core.bufferline",
  "core.dap"
}

function M.load()
  for _, k in pairs(modules) do
    xpcall(function()
      require(k).config()
    end, function(err) return err end)
  end
end

return M
