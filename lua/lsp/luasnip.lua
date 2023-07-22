require("luasnip").config.set_config()
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({ paths = dvim.core.lspconfig.luasnip.vscode_snippets_path })
require("luasnip.loaders.from_snipmate").load()
require("luasnip.loaders.from_snipmate").lazy_load({ paths = dvim.core.lspconfig.luasnip.snipmate_snippets_path or "" })
require("luasnip.loaders.from_lua").load()
require("luasnip.loaders.from_lua").lazy_load({ paths = dvim.core.lspconfig.luasnip.lua_snippets_path or "" })
vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		if
			require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()]
			and not require("luasnip").session.jump_active
		then
			require("luasnip").unlink_current()
		end
	end,
})
