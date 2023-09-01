local dvim_lsp = require("lsp")
local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")

local capabilities = dvim_lsp.capabilities()

local themer = require("themer")
local theme = themer.get_theme_table().hex

require("barbecue").setup({
	theme = {
		separator = { fg = theme.white },
	},
	symbols = {
		separator = dvim.icons.ui.right_arrow,
	},
	attach_navic = false,
	create_autocmd = false,
})

vim.api.nvim_create_autocmd({
	"WinScrolled", -- or WinResized on NVIM-v0.9 and higher
	"BufRead",
	"CursorHold",
	"InsertLeave",
	"BufModifiedSet",
}, {
	group = vim.api.nvim_create_augroup("barbecue.updater", {}),
	callback = function()
		require("barbecue.ui").update()
	end,
})

mason_lspconfig.setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				if client.server_capabilities["documentSymbolProvider"] then
					require("nvim-navic").attach(client, bufnr)
				end
			end,
		})
	end,
	["lua_ls"] = function()
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				if client.server_capabilities["documentSymbolProvider"] then
					require("nvim-navic").attach(client, bufnr)
				end
			end,
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					diagnostics = {
						globals = {
							"vim",
							"dvim",
							"dvim_runtime_dir",
							"dvim_config_dir",
							"dvim_cache_dir",
						},
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
							[require("neodev.config").types()] = true,
							["${3rd}/busted/library"] = true,
							["${3rd}/luassert/library"] = true,
							["${3rd}/luv/library"] = true,
						},
						maxPreload = 5000,
						preloadFileSize = 10000,
					},
				},
			},
		})
	end,
	["tailwindcss"] = function()
		lspconfig.tailwindcss.setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				if client.server_capabilities["documentSymbolProvider"] then
					require("nvim-navic").attach(client, bufnr)
				end
			end,
			root_dir = function(fname)
				local util = require("lspconfig/util")
				return util.root_pattern("tailwind.config.js", "tailwind.config.cjs", "tailwind.js", "tailwind.cjs")(
					fname
				)
			end,
			init_options = {
				userLanguages = {
					jsx = "javascriptreact",
					tsx = "typescriptreact",
					css = "css",
					html = "html",
				},
			},
			{
				"aspnetcorerazor",
				"astro",
				"astro-markdown",
				"blade",
				"django-html",
				"htmldjango",
				"edge",
				"eelixir",
				"elixir",
				"ejs",
				"erb",
				"eruby",
				"gohtml",
				"haml",
				"handlebars",
				"hbs",
				"html",
				"html-eex",
				"heex",
				"jade",
				"leaf",
				"liquid",
				"mdx",
				"mustache",
				"njk",
				"nunjucks",
				"php",
				"razor",
				"slim",
				"twig",
				"css",
				"less",
				"postcss",
				"sass",
				"scss",
				"stylus",
				"sugarss",
				"javascript",
				"javascriptreact",
				"jsx",
				"reason",
				"rescript",
				"typescript",
				"typescriptreact",
				"tsx",
				"vue",
				"svelte",
			},
		})
	end,
})
