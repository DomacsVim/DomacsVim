return {
	{
		"https://github.com/domacsvim/themer",
		config = function()
			local themer = require("themer")
			themer.apply_theme()
		end,
		lazy = false,
	},
	{
		"https://github.com/nvim-tree/nvim-tree.lua",
		config = function()
			require("core.nvimtree").setup()
		end,
		enabled = dvim.core.nvimtree.active,
		cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle" },
		event = "User DirOpened",
		lazy = true,
	},
	{
		"https://github.com/nvim-treesitter/nvim-treesitter",
		config = function()
			require("core.treesitter").setup()
		end,
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
		lazy = true,
	},
	{
		"https://github.com/lewis6991/gitsigns.nvim",
		config = function()
			require("core.gitsigns").setup()
		end,
		event = "BufReadPost",
		cmd = "Gitsigns",
		enabled = dvim.core.gitsigns.active,
		lazy = true,
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
		lazy = true,
	},
	{
		"https://github.com/nvim-telescope/telescope-file-browser.nvim",
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
	-- {
	-- 	"https://github.com/numToStr/Comment.nvim",
	-- 	config = function()
	-- 		require("core.comment").setup()
	-- 	end,
	-- 	event = { "BufReadPost", "BufNewFile" },
	-- 	enabled = dvim.core.comment.active,
	-- },
  {
    "https://github.com/JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
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
		enabled = dvim.core.indentlines.active,
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
	{
		"https://github.com/folke/which-key.nvim",
		config = function()
			require("core.whichkey").setup()
		end,
		cmd = "WhichKey",
		event = "VeryLazy",
		enabled = dvim.core.which_key.active,
	},
	{
		"https://github.com/norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
		event = { "BufReadPost", "BufNewFile" },
	},
  {
    "https://github.com/nvim-lualine/lualine.nvim",
    config = function()
      require("core.lualine").setup()
    end,
    event = "VimEnter",
  },
	{
		"https://github.com/akinsho/bufferline.nvim",
		config = function()
			require("core.bufferline").setup()
		end,
    event = "VimEnter",
	},
  { "https://github.com/neovim/nvim-lspconfig", lazy = true },
  {
    "https://github.com/williamboman/mason.nvim",
    config = function()
      require("core.mason").setup()
    end,
    cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
    build = function()
      pcall(function()
        require("mason-registry").refresh()
      end)
    end,
    event = "User FileOpened",
    lazy = true,
  },
  {
    "https://github.com/williamboman/mason-lspconfig.nvim",
    cmd = { "LspInstall", "LspUninstall" },
    lazy = true,
    event = "User FileOpened"
  },
  {
    "https://github.com/stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true
  },
  { "https://github.com/utilyre/barbecue.nvim", lazy = true },
  { "https://github.com/tamago324/nlsp-settings.nvim", cmd = "LspSettings", lazy = true },
  {
    "https://github.com/SmiteshP/nvim-navic",
    config = function()
      require("core.breadcrumbs").setup()
    end,
    event = "User FileOpened",
  },
  { "https://github.com/folke/neodev.nvim", lazy = true },
  {
    "https://github.com/hrsh7th/nvim-cmp",
    config = function()
      require("core.cmp").setup()
    end,
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "cmp-nvim-lsp",
      "cmp_luasnip",
      "cmp-buffer",
      "cmp-path",
      "cmp-cmdline",
    },
  },
  { "https://github.com/hrsh7th/cmp-nvim-lsp", lazy = true },
  { "https://github.com/saadparwaiz1/cmp_luasnip", lazy = true },
  { "https://github.com/hrsh7th/cmp-buffer", lazy = true },
  { "https://github.com/hrsh7th/cmp-path", lazy = true },
  {
    "https://github.com/hrsh7th/cmp-cmdline",
    lazy = true,
  },
  {
    "https://github.com/L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = {
      "friendly-snippets",
    },
  },
  { "https://github.com/rafamadriz/friendly-snippets", lazy = true, cond = dvim.lsp.luasnip.sources.friendly_snippets },
  {
    "https://github.com/folke/neodev.nvim",
    lazy = true,
  },
  { "https://github.com/nvim-neotest/nvim-nio" },
	{
		"https://github.com/mfussenegger/nvim-dap",
		config = function()
			require("core.dap").setup()
		end,
		event = { "BufReadPost", "BufNewFile" },
	},
	{
		"https://github.com/rcarriga/nvim-dap-ui",
		config = function()
			require("core.dap").ui()
		end,
		event = { "BufReadPost", "BufNewFile" },
	},
	{
		"https://github.com/jay-babu/mason-nvim-dap.nvim",
		config = function()
			require("mason-nvim-dap").setup({
				handlers = {
					function(config)
						require("mason-nvim-dap").default_setup(config)
					end,
				},
			})
		end,
		event = { "BufReadPost", "BufNewFile" },
	},
}
