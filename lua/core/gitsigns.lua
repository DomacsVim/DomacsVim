local M = {}

local log = require("utils.log")

-- default configurations
M.defaults = {
	active = true,
	keymappings = {
		normal_mode = {
			["gh"] = ":Gitsigns reset_hunk<CR>",
			["gn"] = ":Gitsigns next_hunk<CR>",
			["gp"] = ":Gitsigns prev_hunk<CR>",
			["gk"] = ":Gitsigns preview_hunk<CR>",
			["gi"] = ":Gitsigns preview_hunk_inline<CR>",
		},
	},
	configs = {
    signs = {
      add = { text = dvim.icons.ui.BoldLineLeft },
      change = { text = dvim.icons.ui.BoldLineLeft },
      delete = { text = dvim.icons.ui.right_select },
      topdelete = { text = dvim.icons.ui.top_select },
      changedelete = { text = dvim.icons.ui.right_select },
    },
		signcolumn = true,
		numhl = false,
		linehl = false,
		word_diff = false,
		watch_gitdir = {
			interval = 1000,
			follow_files = true,
		},
		attach_to_untracked = true,
		current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 1000,
			ignore_whitespace = false,
		},
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
		sign_priority = 6,
		status_formatter = nil, -- Use default
		update_debounce = 200,
		max_file_length = 40000,
		preview_config = {
			-- Options passed to nvim_open_win
			border = "rounded",
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
	},
}

function M.setup()
	local status_ok, gitsigns = pcall(require, "gitsigns")
	if not status_ok then
		log:ERROR("Failed to load gitsigns module.")
		return
	end

	gitsigns.setup(dvim.core.gitsigns.configs)
end

return M
