local function lazy_load(plugin)
	vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
		group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
		callback = function()
			local file = vim.fn.expand("%")
			local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""

			if condition then
				vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)

				-- dont defer for treesitter as it will show slow highlighting
				-- This deferring only happens only when we do "nvim filename"
				if plugin ~= "nvim-treesitter" then
					vim.schedule(function()
						require("lazy").load({ plugins = plugin })
					end)
				else
					require("lazy").load({ plugins = plugin })
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
		end,
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
		init = function()
			lazy_load("nvim-treesitter")
		end,
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		config = function()
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
	{
		"https://github.com/nvim-lua/plenary.nvim",
		cmd = { "PlenaryBustedFile", "PlenaryBustedDirectory" },
		lazy = true,
	},
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
				},
			}, dvim.core.telescope.defaults)
			pcall(function()
				telescope.load_extension("projects")
			end)
			pcall(function()
				require("telescope").load_extension("fzf")
			end)
			pcall(function()
				require("telescope").load_extension("file_browser")
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
		config = function(_, opts)
			require("Comment").setup(opts)
		end,
	},
	{
		"https://github.com/folke/which-key.nvim",
		keys = { "<leader>", '"', "'", "`", "c", "v", "g" },
		event = "VeryLazy",
		config = function()
			require("core.whichkey").setup()
		end,
	},
	{
		"https://github.com/nvim-tree/nvim-web-devicons",
		lazy = true,
		opts = function()
			return { override = dvim.icons.devicons() }
		end,
		config = function(_, opts)
			require("nvim-web-devicons").setup(opts)
		end,
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
			require("core.terminal").setup()
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
				show_current_context_start = false,
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
		end,
	},
	{
		"https://github.com/goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
			require("core.dashboard").setup()
		end,
	},
	{
		"https://github.com/williamboman/mason.nvim",
		config = function()
			require("core.mason").setup()
		end,
	},
	{ "https://github.com/williamboman/mason-lspconfig.nvim" },
	{ "https://github.com/neovim/nvim-lspconfig" },
	{ "https://github.com/tamago324/nlsp-settings.nvim", cmd = "LspSettings" },
	{
		"https://github.com/williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
		build = function()
			pcall(function()
				require("mason-registry").refresh()
			end)
		end,
	},
	{
		"https://github.com/hrsh7th/nvim-cmp",
		event = { "InsertEnter" },
		config = function()
			require("core.cmp").setup()
		end,
	},
	{ "https://github.com/hrsh7th/cmp-nvim-lsp", lazy = true },
	{ "https://github.com/saadparwaiz1/cmp_luasnip", lazy = true },
	{ "https://github.com/hrsh7th/cmp-buffer", lazy = true },
	{ "https://github.com/hrsh7th/cmp-path", lazy = true },
	{
		"https://github.com/L3MON4D3/LuaSnip",
		config = function()
			require("lsp.defaults")
			require("lsp.luasnip")
		end,
	},
	{ "https://github.com/rafamadriz/friendly-snippets", lazy = true },
	{ "https://github.com/folke/neodev.nvim", lazy = true },
	{
		"https://github.com/akinsho/bufferline.nvim",
		config = function()
			require("core.bufferline").setup()
		end,
	},
	{
		"https://github.com/mfussenegger/nvim-dap",
		config = function()
			require("core.dap").setup()
		end,
	},
	{
		"https://github.com/rcarriga/nvim-dap-ui",
		config = function()
			require("core.dap").ui()
		end,
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
	},
	{ "https://github.com/SmiteshP/nvim-navic" },
	{ "https://github.com/utilyre/barbecue.nvim" },
  {
    "https://github.com/windwp/nvim-ts-autotag",
    cofnig = function()
      local filetypes = {
        'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript',
        'xml', 'php', 'markdown', 'astro', 'glimmer', 'handlebars', 'hbs'
      }
      require('nvim-ts-autotag').setup {
          filetypes = filetypes
      }
    end
  },
  {
    "https://github.com/ivanjermakov/troublesum.nvim",
    config = function()
      local severity_format = { dvim.icons.ui.error, dvim.icons.ui.warn, dvim.icons.ui.hing, dvim.icons.ui.info }
      local severity_highlight = { "DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint" }
      require("troublesum").setup({
        enabled = true,
        autocmd = true,
        severity_format = severity_format,
        severity_highlight = severity_highlight,
        format = function(counts)
          local text = {}
          for severity, count in pairs(counts) do
              if count ~= 0 then
                  if #text ~= 0 then
                      table.insert(text, { " ", "Normal" })
                  end
                  if severity_format[severity] ~= nil then
                    table.insert(text, {
                      table.concat({ severity_format[severity], tostring(count) }, " "),
                      severity_highlight[severity]
                    })
                  end
              end
          end
          return text
        end,
        display_summary = function(bufnr, ns, text)
          local line = vim.fn.line("w0") - 1
          if line then
            vim.api.nvim_buf_set_extmark(bufnr, ns, line, 0, {
                virt_text = text,
                virt_text_pos = "right_align"
            })
          end
        end
      })
    end
  }
}
