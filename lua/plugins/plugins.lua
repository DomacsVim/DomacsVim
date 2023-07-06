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
  {
    "https://github.com/nvim-treesitter/nvim-treesitter",
    cmd = {
      "TSInstall",
      "TSUninstall",
      "TSUpdate",
      "TSUpdateSync",
      "TSInstallInfo",
      "TSInstallSync",
      "TSInstallFromGrammar",
    },
    event = "User FileOpened",
    config = function()
      local path = vim.fn.stdpath "data" .. "/lazy/nvim-treesitter"
      vim.opt.rtp:prepend(path) -- treesitter needs to be before nvim's runtime in rtp
      require("core.treesitter").setup()
    end,
  },
  {
    "https://github.com/windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("core.autopairs").setup()
    end,
  },
  {
    "https://github.com/lewis6991/gitsigns.nvim",
    event = "User FileOpened",
    cmd = "Gitsigns",
    config = function()
      require("core.gitsigns").setup()
    end,
  },
  {
    "https://github.com/ahmedkhalf/project.nvim",
    config = function()
      local status_ok, project = pcall(require, "project_nvim")
      if not status_ok then
        return
      end
      dvim.core.project = {}
      project.setup(dvim.core.project)
    end,
    event = "VimEnter",
    cmd = "Telescope projects",
  },
  { "https://github.com/nvim-lua/plenary.nvim", cmd = { "PlenaryBustedFile", "PlenaryBustedDirectory" }, lazy = true },
  {
    "https://github.com/nvim-telescope/telescope.nvim",
    config = function()
      require("core.telescope").setup()
    end,
    dependencies = { "telescope-fzf-native.nvim" },
    lazy = true,
    cmd = "Telescope",
  },
  { "https://github.com/nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
}
