local function lazy_load(plugin)
  vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
    callback = function()
      local file = vim.fn.expand "%"
      local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

      if condition then
        vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

        -- dont defer for treesitter as it will show slow highlighting
        -- This deferring only happens only when we do "nvim filename"
        if plugin ~= "nvim-treesitter" then
          vim.schedule(function()
            require("lazy").load { plugins = plugin }

            if plugin == "nvim-lspconfig" then
              vim.cmd "silent! do FileType"
            end
          end, 0)
        else
          require("lazy").load { plugins = plugin }
        end
      end
    end,
  })
end

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
    opts = function()
      return require("core.nvimtree")
    end,
    config = function(_, opts)
      require("nvim-tree").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    init = function()
      lazy_load("nvim-treesitter")
    end,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    opts = function()
      return require("core.treesitter")
    end,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "https://github.com/windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = function()
      return require("core.autopairs")
    end,
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
    end,
  },
  {
    "https://github.com/lewis6991/gitsigns.nvim",
    event = "User FileOpened",
    cmd = "Gitsigns",
    init = function()
      lazy_load("gitsigns.nvim")
    end,
    opts = function()
      return require("core.gitsigns")
    end,
    config = function(_, opts)
      require("gitsigns").setup(opts)
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
    opts = function()
      return require("core.telescope")
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)

      pcall(function()
        telescope.load_extension("projects")
      end)
    end,
    dependencies = { "telescope-fzf-native.nvim" },
    lazy = true,
    cmd = "Telescope",
  },
  { "https://github.com/nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
}
