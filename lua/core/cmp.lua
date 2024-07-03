local M = {}

local function has_words_before()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function border(hl_name)
	return {
		{ "╭", hl_name },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end

M.defaults = {
  configs = {
		confirm_opts = {
			select = false,
		},
		completion = {
			---@usage The minimum length of a word to complete on.
			keyword_length = 1,
		},
		experimental = {
			ghost_text = false,
			native_menu = false,
		},
		formatting = {
			max_width = 0,
			kind_icons = dvim.icons.kind_icons,
			source_names = {
				nvim_lsp = "(LSP)",
				emoji = "(Emoji)",
				path = "(Path)",
				calc = "(Calc)",
				cmp_tabnine = "(Tabnine)",
				vsnip = "(Snippet)",
				luasnip = "(Snippet)",
				buffer = "(Buffer)",
				tmux = "(TMUX)",
				copilot = "(Copilot)",
				treesitter = "(TreeSitter)",
			},
			duplicates = {
				buffer = 1,
				path = 1,
				nvim_lsp = 0,
				luasnip = 1,
			},
			duplicates_default = 0,
			fields = { "abbr", "menu", "kind" },
			format = function(entry, vim_item)
				vim_item.kind =
					string.format("%s  %s", dvim.core.cmp.configs.formatting.kind_icons[vim_item.kind], vim_item.kind)
				vim_item.menu = dvim.core.cmp.configs.formatting.source_names[entry.source.name]
				return vim_item
			end,
		},
		snippet = {},
		window = {
			completion = {
				winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:PmenuSel",
				scrollbar = false,
				border = border("CmpDocBorder"),
			},
			documentation = {
				winhighlight = "CmpNormal:CmpDoc",
				border = border("CmpDocBorder"),
			},
		},
		sources = {
			{
				name = "nvim_lsp",
				entry_filter = function(entry, ctx)
					local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
					if kind == "Snippet" and ctx.prev_context.filetype == "java" then
						return false
					end
					return true
				end,
			},
			{ name = "path" },
			{ name = "luasnip" },
			{ name = "cmp_tabnine" },
			{ name = "nvim_lua" },
			{ name = "buffer" },
			{ name = "calc" },
			{ name = "emoji" },
			{ name = "treesitter" },
			{ name = "crates" },
			{ name = "tmux" },
		},
  }
}

function M.setup()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	local cmp_types = require("cmp.types.cmp")
	local cmp_mapping = require("cmp.config.mapping")

	local ConfirmBehavior = cmp_types.ConfirmBehavior
	local SelectBehavior = cmp_types.SelectBehavior

	dvim.core.cmp.configs.confirm_opts.behavior = ConfirmBehavior.Replace

	dvim.core.cmp.configs.snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	}

	dvim.core.cmp.configs.mapping = cmp_mapping.preset.insert({
		["<Down>"] = cmp_mapping(cmp_mapping.select_next_item({ behavior = SelectBehavior.Select }), { "i" }),
		["<Up>"] = cmp_mapping(cmp_mapping.select_prev_item({ behavior = SelectBehavior.Select }), { "i" }),
		["<C-k>"] = cmp_mapping.scroll_docs(-4),
		["<C-j>"] = cmp_mapping.scroll_docs(4),
		["<C-y>"] = cmp_mapping({
			i = cmp_mapping.confirm({ behavior = ConfirmBehavior.Replace, select = false }),
			c = function(fallback)
				if cmp.visible() then
					cmp.confirm({ behavior = ConfirmBehavior.Replace, select = false })
				else
					fallback()
				end
			end,
		}),
		["<C-n>"] = cmp_mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			elseif has_words_before() then
				fallback()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-p>"] = cmp_mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-Space>"] = cmp_mapping.complete(),
		["<C-e>"] = cmp_mapping.abort(),
		["<Tab>"] = cmp_mapping(function(fallback)
			if cmp.visible() then
				local confirm_opts = vim.deepcopy(dvim.core.cmp.configs.confirm_opts) -- avoid mutating the original opts below
				local is_insert_mode = function()
					return vim.api.nvim_get_mode().mode:sub(1, 1) == "i"
				end
				if is_insert_mode() then -- prevent overwriting brackets
					confirm_opts.behavior = ConfirmBehavior.Insert
				end
				if cmp.confirm(dvim.core.cmp.configs.confirm_opts) then
					return -- success, exit early
				end
			end
			fallback() -- if not exited early, always fallback
		end),
	})

	cmp.setup(dvim.core.cmp.configs)
end

return M
