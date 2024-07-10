local M = {}

M.defaults = {
	configs = {
		winbar_filetype_exclude = {
			"help",
			"startify",
			"dashboard",
			"lazy",
			"neo-tree",
			"neogitstatus",
			"NvimTree",
			"Trouble",
			"alpha",
			"lir",
			"Outline",
			"spectre_panel",
			"toggleterm",
			"DressingSelect",
			"Jaq",
			"harpoon",
			"dap-repl",
			"dap-terminal",
			"dapui_console",
			"dapui_hover",
			"lab",
			"notify",
			"noice",
			"neotest-summary",
			"",
		},
		options = {
			icons = {
				Array = dvim.icons.kind_icons.Array .. " ",
				Boolean = dvim.icons.kind_icons.Boolean .. " ",
				Class = dvim.icons.kind_icons.Class .. " ",
				Color = dvim.icons.kind_icons.Color .. " ",
				Constant = dvim.icons.kind_icons.Constant .. " ",
				Constructor = dvim.icons.kind_icons.Constructor .. " ",
				Enum = dvim.icons.kind_icons.Enum .. " ",
				EnumMember = dvim.icons.kind_icons.EnumMember .. " ",
				Event = dvim.icons.kind_icons.Event .. " ",
				Field = dvim.icons.kind_icons.Field .. " ",
				File = dvim.icons.kind_icons.File .. " ",
				Folder = dvim.icons.kind_icons.Folder .. " ",
				Function = dvim.icons.kind_icons.Function .. " ",
				Interface = dvim.icons.kind_icons.Interface .. " ",
				Key = dvim.icons.kind_icons.Key .. " ",
				Keyword = dvim.icons.kind_icons.Keyword .. " ",
				Method = dvim.icons.kind_icons.Method .. " ",
				Module = dvim.icons.kind_icons.Module .. " ",
				Namespace = dvim.icons.kind_icons.Namespace .. " ",
				Null = dvim.icons.kind_icons.Null .. " ",
				Number = dvim.icons.kind_icons.Number .. " ",
				Object = dvim.icons.kind_icons.Object .. " ",
				Operator = dvim.icons.kind_icons.Operator .. " ",
				Package = dvim.icons.kind_icons.Package .. " ",
				Property = dvim.icons.kind_icons.Property .. " ",
				Reference = dvim.icons.kind_icons.Reference .. " ",
				Snippet = dvim.icons.kind_icons.Snippet .. " ",
				String = dvim.icons.kind_icons.String .. " ",
				Struct = dvim.icons.kind_icons.Struct .. " ",
				Text = dvim.icons.kind_icons.Text .. " ",
				TypeParameter = dvim.icons.kind_icons.TypeParameter .. " ",
				Unit = dvim.icons.kind_icons.Unit .. " ",
				Value = dvim.icons.kind_icons.Value .. " ",
				Variable = dvim.icons.kind_icons.Variable .. " ",
			},
			highlight = true,
			separator = " " .. dvim.icons.ui.right_arrow .. " ",
			depth_limit = 0,
			depth_limit_indicator = "..",
		},
	},
}

function M.setup()
	local status_ok, navic = pcall(require, "nvim-navic")
	if not status_ok then
		return
	end

	navic.setup(dvim.core.breadcrumbs.options)
end

return M
