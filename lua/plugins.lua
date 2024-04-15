return {
  {
    "https://gitlab.com/domacsvim/themer",
    config = function()
      local themer = require 'themer'
      themer.apply_theme()
    end,
    lazy = false
  },
  {
    "https://github.com/nvim-tree/nvim-tree.lua",
    config = function()
      require("core.nvimtree").setup()
    end,
    enabled = dvim.core.nvimtree.active,
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle" },
    event = "User DirOpened",
  },
  {
    "https://github.com/nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    config = function()
      require("core.treesitter").setup()
    end,
  },
}
