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
    event = { "BufReadPost", "BufNewFile" },
    enabled = dvim.core.comment.active,
  },
  {
    "https://github.com/nvim-tree/nvim-web-devicons",
    enabled = dvim.icons.active,
    lazy = true,
  },
  {
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    config = function()
      require("core.indentlines").setup()
    end,
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    enabled = dvim.core.indentlines.active
  },
  {
    "https://github.com/akinsho/toggleterm.nvim",
    branch = "main",
    config = function()
      require("core.terminal").setup()
    end,
    cmd = {
      "ToggleTerm",
      "TermExec",
      "ToggleTermToggleAll",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualLines",
      "ToggleTermSendVisualSelection",
    },
    enabled = dvim.core.terminal.active,
  },
  {
    "https://github.com/goolord/alpha-nvim",
    config = function()
      require("core.dashboard").setup()
    end,
    enabled = dvim.core.dashboard.active,
    event = "VimEnter",
  },
}
