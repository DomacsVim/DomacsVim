local M = {}

-- default configurations
M.defaults = {
  active = true,
  keymappings = {
    normal_mode = {
      ["<C-b>"] = ":Telescope file_browser<cr>"
    }
  },
  configs = {
		defaults = {
			vimgrep_arguments = {
				"rg",
				"-L",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			prompt_prefix = dvim.icons.ui.search .. " ",
			selection_caret = "  ",
			entry_prefix = "  ",
			initial_mode = "insert",
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.80,
				height = 0.73,
				preview_cutoff = 120,
			},
		},
		extensions = {
      file_browser = {
        theme = "ivy",
        hijack_netrw = true,
      },
    },
  }
}

function M.setup()
  local status_ok, telescope = pcall(require, "telescope")
  if not status_ok then
    log:ERROR("Failed to load telescope module.")
    return
  end

	dvim.core.telescope.configs.defaults = vim.tbl_extend("keep", {
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
	}, dvim.core.telescope.configs.defaults)
	pcall(function()
		telescope.load_extension("projects")
	end)
	pcall(function()
		telescope.load_extension("file_browser")
	end)
	telescope.setup(dvim.core.telescope.configs)
end

return M
