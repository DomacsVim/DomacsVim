return {
  { 
    "https://github.com/folke/tokyonight.nvim",
    config = function()
      vim.cmd("colorscheme tokyonight-night")
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
  {
    "https://github.com/ahmedkhalf/project.nvim",
    config = function()
      require("core.project").setup()
    end,
    enabled = dvim.core.project.active,
    event = "VimEnter",
    cmd = "Telescope projects",
  },
  {
    "https://github.com/nvim-lua/plenary.nvim",
    cmd = { "PlenaryBustedFile", "PlenaryBustedDirectory" },
    lazy = true
  },
  {
    "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  {
    "https://github.com/nvim-telescope/telescope.nvim",
    config = function()
      require("core.telescope").setup()
    end,
    lazy = true,
    cmd = "Telescope",
    enabled = dvim.core.telescope.active,
  },
  {
    "https://github.com/windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("core.autopairs").setup()
    end,
    enabled = dvim.core.autopairs.active,
  },
  {
    "https://github.com/numToStr/Comment.nvim",
    config = function()
      require("core.comment").setup()
    end,
    keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
    event = "User FileOpened",
    enabled = dvim.core.comment.active,
  },
}
