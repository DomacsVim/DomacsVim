local M = {}

-- return a table of default configs
function M.default_configs()
	return {
		keys = {
			leadermap = " ",
			term_mode = {},
			insert_mode = {},
			normal_mode = {},
			visual_mode = {},
			command_mode = {},
		},
		lazy = {},
		plugins = {},
		colorscheme = "onedark"
	}
end

-- load default configs add set dvim global var
function M.load_default_configs()
	dvim = {}
end

return M
