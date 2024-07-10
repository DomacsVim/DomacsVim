local dvim_lsp = require("lsp.configs")
local lspconfig = require("lspconfig")

local capabilities = dvim_lsp.capabilities()

local themer = require("themer")
local theme = themer.themes(dvim.colorscheme)

require("barbecue").setup({
	theme = {
		separator = { fg = theme.base07 },
	},
	symbols = {
		separator = dvim.icons.ui.right_arrow,
	},
	attach_navic = true,
	create_autocmd = true,
	show_dirname = false,
	show_basename = true,
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

local handlers = {
	function(server_name)
		lspconfig[server_name].setup({
			capabilities = capabilities,
			on_init = function(client, _)
				dvim_lsp.on_init(client)
			end,
			on_attach = function(client, bufnr)
				dvim_lsp.on_attach(client, bufnr)
			end,
		})
	end,
	["lua_ls"] = function()
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_init = function(client, _)
				dvim_lsp.on_init(client)
			end,
			on_attach = function(client, bufnr)
				dvim_lsp.on_attach(client, bufnr)
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
			on_init = function(client, _)
				dvim_lsp.on_init(client)
			end,
			on_attach = function(client, bufnr)
				dvim_lsp.on_attach(client, bufnr)
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
}

dvim.lsp.installer.handlers = handlers

require("mason-lspconfig").setup(dvim.lsp.installer)
