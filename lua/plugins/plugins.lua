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
    "https://gitlab.com/domacsvim/themer",
    config = function()
      local themer = require("themer")
      themer.apply_theme()
    end
  },
  { "https://github.com/nvim-lua/plenary.nvim" },
  {
    "https://github.com/nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    event = "User DirOpened",
    config = function()
      require("nvim-tree").setup(dvim.core.nvimtree)
    end,
  },
  {
    "https://github.com/nvim-treesitter/nvim-treesitter",
    init = function()
      lazy_load("nvim-treesitter")
    end,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    config = function()
      require("nvim-treesitter.configs").setup(dvim.core.treesitter)
    end,
  },
  {
    "https://github.com/windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup(dvim.core.autopairs)
    end,
  },
  {
    "https://github.com/lewis6991/gitsigns.nvim",
    event = "User FileOpened",
    cmd = "Gitsigns",
    init = function()
      lazy_load("gitsigns.nvim")
    end,
    config = function()
      require("gitsigns").setup(dvim.core.gitsigns)
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
      local telescope = require("telescope")
      dvim.core.telescope.defaults = vim.tbl_extend("keep", {
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
          n = { ["q"] = require("telescope.actions").close },
        }
      }, dvim.core.telescope.defaults)
      pcall(function()
        telescope.load_extension("projects")
      end)
      pcall(function()
        require("telescope").load_extension "fzf"
      end)
      pcall(function()
        require("telescope").load_extension "file_browser"
      end)
      telescope.setup(dvim.core.telescope)
    end,
    lazy = true,
    cmd = "Telescope",
  },
  { "https://github.com/nvim-telescope/telescope-file-browser.nvim" },
  {
    "https://github.com/numToStr/Comment.nvim",
    opts = function()
      dvim.core.comments = {}
      return dvim.core.comments
    end,
    config = function()
      require("Comment").setup(opts)
    end,
  },
  {
    "https://github.com/folke/which-key.nvim",
    keys = { "<leader>", '"', "'", "`", "c", "v", "g" },
    event = "VeryLazy",
    config = function()
      local whichkey = require("which-key")
      whichkey.setup(dvim.core.whichkey.setup)

      local opt = dvim.core.whichkey.opts
      local vopts = dvim.core.whichkey.vopts

      local mappings = dvim.core.whichkey.mappings
      local vmappings = dvim.core.whichkey.vmappings

      whichkey.register(mappings, opt)
      whichkey.register(vmappings, vopts)
    end,
  },
  { 
    "https://github.com/nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = function()
      return { override = require("icons").devicons }
    end,
    config = function(_, opts)
      require('nvim-web-devicons').setup(opts)
    end
  },
  {
    "https://github.com/norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  },
  {
    "https://github.com/akinsho/toggleterm.nvim",
    cmd = {
      "ToggleTerm",
      "TermExec",
      "ToggleTermToggleAll",
      "ToggleTermSendCurrentLine",
      "ToggleTermSendVisualLines",
      "ToggleTermSendVisualSelection",
    },
    config = function()
      require("toggleterm").setup(dvim.core.terminal)
    end,
  },
  {
    "https://github.com/lukas-reineke/indent-blankline.nvim",
    init = function()
      lazy_load("indent-blankline.nvim")
    end,
    opts = function()
      dvim.core.indentline = {
        indentLine_enabled = 1,
        filetype_exclude = {
          "help",
          "terminal",
          "lazy",
          "alpha",
          "lspinfo",
          "TelescopePrompt",
          "TelescopeResults",
          "mason",
          "",
        },
        buftype_exclude = { "terminal" },
        show_trailing_blankline_indent = false,
        show_first_indent_level = false,
        show_current_context = false,
        show_current_context_start = false
      }
      return dvim.core.indentline
    end,
    config = function(_, opts)
      require("indent_blankline").setup(opts)
    end,
  },
  {
    "https://gitlab.com/domacsvim/statusline",
    config = function()
      local statusline = require("statusline")
      statusline.setup()
    end
  },
  {
    "https://github.com/goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      require("alpha").setup(dvim.core.dashboard)
    end
  },
}
