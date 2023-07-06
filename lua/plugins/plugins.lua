return {
  {
    "https://gitlab.com/domacsvim/base18",
    config = function()
      local base16 = require("base18")
      base16.apply_theme()
    end
  },
  { "https://github.com/nvim-lua/plenary.nvim" },
  {
    "https://github.com/nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    event = "User DirOpened",
    config = function()
      require("core.nvimtree").setup()
    end,
  },
}
