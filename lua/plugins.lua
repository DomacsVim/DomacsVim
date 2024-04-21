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
    lazy = true
  },
  {
    "https://github.com/nvim-treesitter/nvim-treesitter",
    config = function()
      require("core.treesitter").setup()
    end,
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    lazy = true
  },
  {
    "https://github.com/lewis6991/gitsigns.nvim",
    config = function()
      require("core.gitsigns").setup()
    end,
    event = "BufReadPost",
    cmd = "Gitsigns",
    enabled = dvim.core.gitsigns.active,
    lazy = true
  },
}
