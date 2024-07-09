local M = {}

local log = require("utils.log")

M.defaults = {
	active = true,
	keymappings = {},
	configs = {
		plugins = {
			marks = false, -- shows a list of your marks on ' and `
			registers = false, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
			spelling = {
				enabled = true,
				suggestions = 20,
			}, -- use which-key for spelling hints
			-- the presets plugin, adds help for a bunch of default keybindings in Neovim
			-- No actual key bindings are created
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
		-- add operators that will trigger motion and text object completion
		-- to enable all native operators, set the preset / operators plugin above
		key_labels = {
			-- override the label used to display some keys. It doesn't effect WK in any other way.
			-- For example:
			-- ["<space>"] = "SPC",
			-- ["<cr>"] = "RET",
			-- ["<tab>"] = "TAB",
		},
		popup_mappings = {
			scroll_down = "<c-d>", -- binding to scroll down inside the popup
			scroll_up = "<c-u>", -- binding to scroll up inside the popup
		},
		window = {
			border = "single", -- none, single, double, shadow
			position = "bottom", -- bottom, top
			margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
			padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
			winblend = 0,
		},
		layout = {
			height = { min = 4, max = 25 }, -- min and max height of the columns
			width = { min = 20, max = 50 }, -- min and max width of the columns
			spacing = 3, -- spacing between columns
			align = "left", -- align columns left, center or right
		},
		ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
		hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
		show_help = true, -- show help message on the command line when the popup is visible
		show_keys = true, -- show the currently pressed key and its label as a message in the command line
		triggers = "auto", -- or specify a list manually
		triggers_blacklist = {
			-- list of mode / prefixes that should never be hooked by WhichKey
			-- this is mostly relevant for key maps that start with a native binding
			-- most people should not need to change this
			i = { "j", "k" },
			v = { "j", "k" },
		},
		-- disable the WhichKey popup for certain buf types and file types.
		-- Disabled by default for Telescope
		disable = {
			buftypes = {},
			filetypes = { "TelescopePrompt" },
		},
		opts = {
			mode = "n", -- NORMAL mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = true, -- use `nowait` when creating keymaps
		},
		vopts = {
			mode = "v", -- VISUAL mode
			prefix = "<leader>",
			buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
			silent = true, -- use `silent` when creating keymaps
			noremap = true, -- use `noremap` when creating keymaps
			nowait = true, -- use `nowait` when creating keymaps
		},
		-- NOTE: Prefer using : over <cmd> as the latter avoids going back in normal-mode.
		-- see https://neovim.io/doc/user/map.html#:map-cmd
		vmappings = {
			["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
			l = {
				name = "LSP",
				a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
			},
			g = {
				name = "Git",
				r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
				s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
			},
		},
		mappings = {
			[";"] = { "<cmd>Alpha<CR>", "Dashboard" },
			["w"] = { "<cmd>w!<CR>", "Save" },
			["q"] = { "<cmd>confirm q<CR>", "Quit" },
			["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment toggle current line" },
			["c"] = { "<cmd>BufferKill<CR>", "Close Buffer" },
			["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
			["e"] = { "<cmd>NvimTreeToggle<CR>", "Explorer" },
			b = {
				name = "Buffers",
				j = { "<cmd>BufferLinePick<cr>", "Jump" },
				f = { "<cmd>Telescope buffers previewer=false<cr>", "Find" },
				b = { "<cmd>BufferLineCyclePrev<cr>", "Previous" },
				n = { "<cmd>BufferLineCycleNext<cr>", "Next" },
				W = { "<cmd>noautocmd w<cr>", "Save without formatting (noautocmd)" },
				-- w = { "<cmd>BufferWipeout<cr>", "Wipeout" }, -- TODO: implement this for bufferline
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
				D = {
					"<cmd>BufferLineSortByExtension<cr>",
					"Sort by language",
				},
			},
			d = {
				name = "Debug",
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
			p = {
				name = "Plugins",
				i = { "<cmd>Lazy install<cr>", "Install" },
				s = { "<cmd>Lazy sync<cr>", "Sync" },
				S = { "<cmd>Lazy clear<cr>", "Status" },
				c = { "<cmd>Lazy clean<cr>", "Clean" },
				u = { "<cmd>Lazy update<cr>", "Update" },
				p = { "<cmd>Lazy profile<cr>", "Profile" },
				l = { "<cmd>Lazy log<cr>", "Log" },
				d = { "<cmd>Lazy debug<cr>", "Debug" },
			},

			-- " Available Debug Adapters:
			-- "   https://microsoft.github.io/debug-adapter-protocol/implementors/adapters/
			-- " Adapter configuration and installation instructions:
			-- "   https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
			-- " Debug Adapter protocol:
			-- "   https://microsoft.github.io/debug-adapter-protocol/
			-- " Debugging
			g = {
				name = "Git",
				g = { "<cmd>lua require 'core.terminal'.lazygit_toggle()<cr>", "Lazygit" },
				j = { "<cmd>lua require 'gitsigns'.nav_hunk('next', {navigation_message = false})<cr>", "Next Hunk" },
				k = { "<cmd>lua require 'gitsigns'.nav_hunk('prev', {navigation_message = false})<cr>", "Prev Hunk" },
				l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
				L = { "<cmd>lua require 'gitsigns'.blame_line({full=true})<cr>", "Blame Line (full)" },
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
			l = {
				name = "LSP",
				a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
				d = { "<cmd>Telescope diagnostics bufnr=0 theme=get_ivy<cr>", "Buffer Diagnostics" },
				w = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
				-- TODO: formatting
				i = { "<cmd>LspInfo<cr>", "Info" },
				I = { "<cmd>Mason<cr>", "Mason Info" },
				j = {
					"<cmd>lua vim.diagnostic.goto_next()<cr>",
					"Next Diagnostic",
				},
				k = {
					"<cmd>lua vim.diagnostic.goto_prev()<cr>",
					"Prev Diagnostic",
				},
				l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
				q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
				r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
				s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
				S = {
					"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
					"Workspace Symbols",
				},
				e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
			},
			D = {
				name = "+DomacsVim",
				c = {
					"<cmd>edit " .. dvim_config_dir .. "/init.lua<cr>",
					"Edit config.lua",
				},
				-- TODO: open documentation
				k = { "<cmd>Telescope keymaps<cr>", "View DomacsVim's keymappings" },
				-- TODO: create infomation (help) popup
				I = {
					"<cmd>lua require('core.terminal').change_log()<cr>",
					"View DomacsVim's changelog",
				},
				l = {
					name = "+logs",
					d = {
						"<cmd>edit " .. dvim_cache_dir .. "/dvim.log<cr>",
						"view default log",
					},
					N = { "<cmd>edit $NVIM_LOG_FILE<cr>", "Open the Neovim logfile" },
				},
				-- TODO: update command
			},
			s = {
				name = "Search",
				b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
				c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
				f = { "<cmd>Telescope find_files<cr>", "Find File" },
				h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
				H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
				M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
				r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
				R = { "<cmd>Telescope registers<cr>", "Registers" },
				t = { "<cmd>Telescope live_grep<cr>", "Text" },
				k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
				C = { "<cmd>Telescope commands<cr>", "Commands" },
				l = { "<cmd>Telescope resume<cr>", "Resume last search" },
				p = {
					"<cmd>lua require('telescope.core').colorscheme({enable_preview = true})<cr>",
					"Colorscheme with Preview",
				},
			},
			T = {
				name = "Treesitter",
				i = { ":TSConfigInfo<cr>", "Info" },
			},
		},
	},
}

function M.setup()
	local status_ok, whichkey = pcall(require, "which-key")
	if not status_ok then
		log:ERROR("Failed to load which-key module.")
		return
	end

	whichkey.setup(dvim.core.which_key.configs)

	local opts = dvim.core.which_key.configs.opts
	local vopts = dvim.core.which_key.configs.vopts

	local mappings = dvim.core.which_key.configs.mappings
	local vmappings = dvim.core.which_key.configs.vmappings

	whichkey.register(mappings, opts)
	whichkey.register(vmappings, vopts)
end

return M
