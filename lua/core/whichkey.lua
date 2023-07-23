local M = {}

function M.config()
	dvim.core.whichkey = {
		icons = {
			breadcrumb = dvim.icons.ui.breadcrumb, -- symbol used in the command line area that shows your active key combo
			separator = dvim.icons.ui.separator, -- symbol used between a key and it's label
			group = "", -- symbol prepended to a group
		},
		plugins = {
			marks = false, -- shows a list of your marks on ' and `
			registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			presets = {
				operators = false, -- adds help for operators like d, y, ...
				motions = false, -- adds help for motions
				text_objects = false, -- help for text objects triggered after entering an operator
				windows = false, -- default bindings on <c-w>
				nav = false, -- misc bindings to work with windows
				z = false, -- bindings for folds, spelling and others prefixed with z
				g = false, -- bindings for prefixed with g
			},
		},
		popup_mappings = {
			scroll_down = "<c-d>", -- binding to scroll down inside the popup
			scroll_up = "<c-u>", -- binding to scroll up inside the popup
		},
		window = {
			border = "none", -- none/single/double/shadow
		},
		layout = {
			height = { min = 1, max = 6 }, -- min and max height of the columns
			spacing = 6, -- spacing between columns
		},
		hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
		triggers_blacklist = {
			-- list of mode / prefixes that should never be hooked by WhichKey
			i = { "j", "k" },
			v = { "j", "k" },
		},
		opts = {
			mode = "n", -- NORMAL mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = true, -- use `nowait` when creating keymaps
		},
		mappings = {
			["f"] = {
				name = "File",
				["n"] = { ":enew<CR>", "New File" },
				["o"] = { ":Telescope find_files<CR>", "Open File" },
				["p"] = { ":Telescope projects<CR>", "Projects" },
				["r"] = { ":Telescope oldfiles<CR>", "Open Recent" },
				["s"] = { ":w!<CR>", "Save" },
				["S"] = { "wa!<CR>", "Save All" },
				["c"] = { ":edit " .. dvim_config_dir .. "/init.lua<CR>", "Preferences" },
				["q"] = { ":q<CR>", "Exit" },
			},
			["e"] = {
				name = "Edit",
				["u"] = { ":undo<cr>", "Undo" },
				["r"] = { ":redo<cr>", "Redo" },
				["a"] = { "ggVG", "Select All" },
				["C"] = { "ggVGy", "Copy All" },
				["p"] = { ":Telescope commands<CR>", "Commands" },
				["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment" },
				["k"] = { ":m .-2<CR>==", "Move Line Up" },
				["j"] = { ":m .+1<CR>==<CR>", "Move Line Down" },
			},
			["s"] = {
				name = "Search",
				b = { ":Telescope git_branches<CR>", "Checkout branch" },
				c = { ":Telescope colorscheme<CR>", "Colorscheme" },
				f = { ":Telescope find_files<CR>", "Find File" },
				h = { ":Telescope help_tags<CR>", "Find Help" },
				H = { ":Telescope highlights<CR>", "Find highlight groups" },
				M = { ":Telescope man_pages<CR>", "Man Pages" },
				r = { ":Telescope oldfiles<CR>", "Open Recent File" },
				R = { ":Telescope registers<CR>", "Registers" },
				t = { ":Telescope live_grep<CR>", "Text" },
				k = { ":Telescope keymaps<CR>", "Keymaps" },
				C = { ":Telescope commands<CR>", "Commands" },
				p = { ":Telescope projects<CR>", "Recent Project" },
			},
			["b"] = {
				name = "Buffers",
				j = { "<cmd>BufferLinePick<cr>", "Jump" },
				f = { "<cmd>Telescope buffers<cr>", "Find" },
				b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
				n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
				e = {
					"<cmd>BufferLinePickClose<cr>",
					"Pick which buffer to close",
				},
				h = { "<cmd>BufferLineCloseLeft<cr>", "Close all to the left" },
				l = {
					"<cmd>BufferLineCloseRight<cr>",
					"Close all to the right",
				},
				D = {
					"<cmd>BufferLineSortByDirectory<cr>",
					"Sort by directory",
				},
				L = {
					"<cmd>BufferLineSortByExtension<cr>",
					"Sort by language",
				},
			},
			["t"] = {
				name = "Terminal",
				p = { "<cmd>lua _PYTHON_TOGGLE()<CR>", "Python" },
				f = { "<cmd>ToggleTerm direction=float<CR>", "Float" },
				h = { "<cmd>ToggleTerm size=10 direction=horizontal<CR>", "Horizontal" },
				v = { "<cmd>ToggleTerm size=80 direction=vertical<CR>", "Vertical" },
			},
			["l"] = {
				name = "Lazy",
				["l"] = { ":Lazy<CR>", "Lazy" },
				["c"] = { ":Lazy clean<CR>", "Lazy Clean" },
				["d"] = { ":Lazy debug<CR>", "Lazy Debug" },
				["h"] = { ":Lazy help<CR>", "Lazy Help" },
				["H"] = { ":Lazy health<CR>", "Lazy Health" },
				["s"] = { ":Lazy sync", "Lazy Sync" },
				["C"] = { ":Lazy update", "Lazy Update" },
				["L"] = { ":Lazy log", "Lazy Log" },
				["r"] = { ":Lazy reload", "Lazy Reload" },
				["i"] = { ":Lazy install", "Lazy Install" },
			},
			["g"] = {
				name = "Git",
				j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
				k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
				l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
				p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
				r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
				R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
				s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
				u = {
					"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
					"Undo Stage Hunk",
				},
				o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
				b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
				c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
				C = {
					"<cmd>Telescope git_bcommits<cr>",
					"Checkout commit(for current file)",
				},
				d = {
					"<cmd>Gitsigns diffthis HEAD<cr>",
					"Git Diff",
				},
			},
			["r"] = {
				name = "Run",
				t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
				b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
				c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
				C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
				d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
				g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
				i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
				o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
				u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
				p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
				r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
				s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
				q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
				U = { "<cmd>lua require'dapui'.toggle({reset = true})<cr>", "Toggle UI" },
			},
			["h"] = {
				name = "Help",
        w = { "<cmd>lua require('help').welcome()<cr>", "Welcome" },
        c = { "<cmd>lua require('help').show_all_commands()<cr>", "Show all commands" },
        d = { "<cmd>lua require('help').documentation()<cr>", "Documentation" },
        k = { "<cmd>lua require('help').keyboard_shortcuts_reference()<cr>", "Keyboard shortcuts reference" },
        r = { "<cmd>lua require('help').report_issue()<cr>", "Report issue" },
        l = { "<cmd>lua require('help').view_license()<cr>", "View licence" },
        a = { "<cmd>lua require('help').about()<cr>", "About" },
			},
		},
	}
end

function M.setup()
	local whichkey = require("which-key")
	whichkey.setup(dvim.core.whichkey)

	local opt = dvim.core.whichkey.opts
	local mappings = dvim.core.whichkey.mappings
	whichkey.register(mappings, opt)
end

return M
