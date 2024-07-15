local M = {}

local log = require("utils.log")
local utils = require("utils.modules")

M.defaults = {
  active = true,
  keymappings = {},
  configs = {
    ---@type false | "classic" | "modern" | "helix"
    preset = "modern",
    -- Delay before showing the popup. Can be a number or a function that returns a number.
    ---@type number | fun(ctx: { keys: string, mode: string, plugin?: string }):number
    delay = function(ctx)
      return ctx.plugin and 0 or 200
    end,
    ---@param mapping wk.Mapping
    filter = function(mapping)
      -- example to exclude mappings without a description
      -- return mapping.desc and mapping.desc ~= ""
      return true
    end,
    --- You can add any mappings here, or use `require('which-key').add()` later
    ---@type wk.Spec
    spec = {
      { "<leader>f",  group = "File" }, -- group
      { "<leader>fn", "<cmd>enew<cr>",                                                         desc = "New File",                          mode = "n" },
      { "<leader>fo", "<cmd>Telescope find_files<cr>",                                         desc = "Open File",                         mode = "n" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                                           desc = "Open Recent",                       mode = "n" },
      { "<leader>fp", "<cmd>Telescope projects<cr>",                                           desc = "Projects",                          mode = "n" },
      { "<leader>fs", "<cmd>w!<cr>",                                                           desc = "Save",                              mode = "n" },
      { "<leader>fS", "<cmd>wa!<cr>",                                                          desc = "Save All",                          mode = "n" },
      { "<leader>fc", "<cmd>edit " .. utils.join_paths(dvim_config_dir, "init.lua") .. "<cr>", desc = "Settings",                          mode = "n" },
      { "<leader>fq", "<cmd>q<cr>",                                                            desc = "Exit",                              mode = "n" },
      { "<leader>e",  group = "Edit" }, -- group
      { "<leader>eu", "<cmd>undo<cr>",                                                         desc = "Undo",                              mode = "n" },
      { "<leader>er", "<cmd>redo<cr>",                                                         desc = "Redo",                              mode = "n" },
      { "<leader>ea", "ggVG",                                                                  desc = "Select All",                        mode = "n" },
      { "<leader>ec", "ggVGy",                                                                 desc = "Copy All",                          mode = "n" },
      { "<leader>ek", "<cmd>m .-2<cr>==",                                                      desc = "Move Line Up",                      mode = "n" },
      { "<leader>ej", "<cmd>m .+1<cr>==<cr>",                                                  desc = "Move Line Down",                    mode = "n" },
      { "<leader>ec", "gcc",                                                                   desc = "Comment This Line",                 mode = "n" },
      { "<leader>s",  group = "Search" }, -- group
      { "<leader>sb", "<cmd>Telescope git_branches<cr>",                                       desc = "Checkout branch",                   mode = "n" },
      { "<leader>sf", "<cmd>Telescope find_files<cr>",                                         desc = "Find File",                         mode = "n" },
      { "<leader>sh", "<cr>Telescope help_tags<cr>",                                           desc = "Find Help",                         mode = "n" },
      { "<leader>sH", "<cmd>Telescope highlights<cr>",                                         desc = "Find highlight groups",             mode = "n" },
      { "<leader>sM", "<cmd>Telescope man_pages<cr>",                                          desc = "Man Pages",                         mode = "n" },
      { "<leader>sr", "<cmd>Telescope oldfiles<cr>",                                           desc = "Open Recent File",                  mode = "n" },
      { "<leader>sR", "<cmd>Telescope registers<cr>",                                          desc = "Registers",                         mode = "n" },
      { "<leader>st", "<cmd>Telescope live_grep<cr>",                                          desc = "Text",                              mode = "n" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>",                                            desc = "Keymaps",                           mode = "n" },
      { "<leader>sc", "<cmd>Telescope commands<cr>",                                           desc = "Commands",                          mode = "n" },
      { "<leader>sp", "<cmd>Telescope projects<cr>",                                           desc = "Recent Project",                    mode = "n" },
      { "<leader>b",  group = "Buffers" }, -- group
      { "<leader>bj", "<cmd>BufferLinePick<cr>",                                               desc = "Jump",                              mode = "n" },
      { "<leader>bf", "<cmd>Telescope buffers<cr>",                                            desc = "Find",                              mode = "n" },
      { "<leader>bb", "<cmd>BufferLineCyclePrev<cr>",                                          desc = "Previous",                          mode = "n" },
      { "<leader>bn", "<cmd>BufferLineCycleNext<cr>",                                          desc = "Next",                              mode = "n" },
      { "<leader>be", "<cmd>BufferLinePickClose<cr>",                                          desc = "Pick which buffer to close",        mode = "n" },
      { "<leader>bh", "<cmd>BufferLineCloseLeft<cr>",                                          desc = "Close all to the left",             mode = "n" },
      { "<leader>bl", "<cmd>BufferLineCloseRight<cr>",                                         desc = "Close all to the right",            mode = "n" },
      { "<leader>bD", "<cmd>BufferLineSortByDirectory<cr>",                                    desc = "Sort by directory",                 mode = "n" },
      { "<leader>bL", "<cmd>BufferLineSortByExtension<cr>",                                    desc = "Sort by language",                  mode = "n" },
      { "<leader>t",  group = "Terminal" }, -- group
      { "<leader>tg", "<cmd>lua require('core.terminal').lazygit_toggle()<cr>",                desc = "Lazygit",                           mode = "n" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",                                   desc = "Float",                             mode = "n" },
      { "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>",                      desc = "Horizontal",                        mode = "n" },
      { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>",                        desc = "Vertical",                          mode = "n" },
      { "<leader>l",  group = "Lazy" }, -- group
      { "<leader>ll", "<cmd>Lazy<cr>",                                                         desc = "Lazy",                              mode = "n" },
      { "<leader>lc", "<cmd>Lazy clean<cr>",                                                   desc = "Lazy Clean",                        mode = "n" },
      { "<leader>ld", "<cmd>Lazy debug<cr>",                                                   desc = "Lazy Debug",                        mode = "n" },
      { "<leader>lh", "<cmd>Lazy help<cr>",                                                    desc = "Lazy Help",                         mode = "n" },
      { "<leader>lH", "<cmd>Lazy health<cr>",                                                  desc = "Lazy Health",                       mode = "n" },
      { "<leader>ls", "<cmd>Lazy sync<cr>",                                                    desc = "Lazy Sync",                         mode = "n" },
      { "<leader>lC", "<cmd>Lazy update<cr>",                                                  desc = "Lazy Update",                       mode = "n" },
      { "<leader>lL", "<cmd>Lazy log<cr>",                                                     desc = "Lazy Log",                          mode = "n" },
      { "<leader>lr", "<cmd>Lazy reload<cr>",                                                  desc = "Lazy Reload",                       mode = "n" },
      { "<leader>li", "<cmd>Lazy install<cr>",                                                 desc = "Lazy Install",                      mode = "n" },
      { "<leader>g",  group = "Git" }, -- group
      { "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>",                           desc = "Next Hunk",                         mode = "n" },
      { "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",                           desc = "Prev Hunk",                         mode = "n" },
      { "<leader>gl", "<cmd>lua require 'gitsigns'.blame_line()<cr>",                          desc = "Blame",                             mode = "n" },
      { "<leader>gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",                        desc = "Preview Hunk",                      mode = "n" },
      { "<leader>gr", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",                          desc = "Reset Hunk",                        mode = "n" },
      { "<leader>gR", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",                        desc = "Reset Buffer",                      mode = "n" },
      { "<leader>gs", "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",                          desc = "Stage Hunk",                        mode = "n" },
      { "<leader>gu", "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",                     desc = "Undo Stage Hunk",                   mode = "n" },
      { "<leader>go", "<cmd>Telescope git_status<cr>",                                         desc = "Open changed file",                 mode = "n" },
      { "<leader>gb", "<cmd>Telescope git_branches<cr>",                                       desc = "Checkout branch",                   mode = "n" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>",                                        desc = "Checkout commit",                   mode = "n" },
      { "<leader>gC", "<cmd>Telescope git_bcommits<cr>",                                       desc = "Checkout commit(for current file)", mode = "n" },
      { "<leader>gd", "<cmd>Gitsigns diffthis HEAD<cr>",                                       desc = "Git Diff",                          mode = "n" },
      { "<leader>r",  group = "Run" }, -- group
      { "<leader>rt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>",                         desc = "Toggle Breakpoint",                 mode = "n" },
      { "<leader>rb", "<cmd>lua require'dap'.step_back()<cr>",                                 desc = "Step Back",                         mode = "n" },
      { "<leader>rc", "<cmd>lua require'dap'.continue()<cr>",                                  desc = "Continue",                          mode = "n" },
      { "<leader>rC", "<cmd>lua require'dap'.run_to_cursor()<cr>",                             desc = "Run To Cursor",                     mode = "n" },
      { "<leader>rd", "<cmd>lua require'dap'.disconnect()<cr>",                                desc = "Disconnect",                        mode = "n" },
      { "<leader>rg", "<cmd>lua require'dap'.session()<cr>",                                   desc = "Get Session",                       mode = "n" },
      { "<leader>ri", "<cmd>lua require'dap'.step_into()<cr>",                                 desc = "Step Into",                         mode = "n" },
      { "<leader>ro", "<cmd>lua require'dap'.step_over()<cr>",                                 desc = "Step Over",                         mode = "n" },
      { "<leader>ru", "<cmd>lua require'dap'.step_out()<cr>",                                  desc = "Step Out",                          mode = "n" },
      { "<leader>rp", "<cmd>lua require'dap'.pause()<cr>",                                     desc = "Pause",                             mode = "n" },
      { "<leader>rr", "<cmd>lua require'dap'.repl.toggle()<cr>",                               desc = "Toggle Repl",                       mode = "n" },
      { "<leader>rs", "<cmd>lua require'dap'.continue()<cr>",                                  desc = "Start",                             mode = "n" },
      { "<leader>rq", "<cmd>lua require'dap'.close()<cr>",                                     desc = "Quit",                              mode = "n" },
      { "<leader>rU", "<cmd>lua require'dapui'.toggle({reset = true})<cr>",                    desc = "Toggle UI",                         mode = "n" },
      { "<leader>D",  group = "DomacsVim" }, -- group
      { "<leader>Dw", "<cmd>lua require('help').welcome()<cr>",                                desc = "Welcome",                           mode = "n" },
      { "<leader>Dc", "<cmd>lua require('help').show_all_commands()<cr>",                      desc = "Show all commands",                 mode = "n" },
      { "<leader>Dd", "<cmd>lua require('help').documentation()<cr>",                          desc = "Documentation",                     mode = "n" },
      { "<leader>Dk", "<cmd>lua require('help').keyboard_shortcuts_reference()<cr>",           desc = "Keyboard shortcuts reference",      mode = "n" },
      { "<leader>Dr", "<cmd>lua require('help').report_issue()<cr>",                           desc = "Report issue",                      mode = "n" },
      { "<leader>Dl", "<cmd>lua require('help').view_license()<cr>",                           desc = "View licence",                      mode = "n" },
      { "<leader>Da", "<cmd>lua require('help').about()<cr>",                                  desc = "About",                             mode = "n" },
    },
    -- show a warning when issues were detected with your mappings
    notify = true,
    -- Enable/disable WhichKey for certain mapping modes
    modes = {
      n = true, -- Normal mode
      i = true, -- Insert mode
      x = true, -- Visual mode
      s = true, -- Select mode
      o = true, -- Operator pending mode
      t = true, -- Terminal mode
      c = true, -- Command mode
    },
    plugins = {
      marks = true,     -- shows a list of your marks on ' and `
      registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
      -- the presets plugin, adds help for a bunch of default keybindings in Neovim
      -- No actual key bindings are created
      spelling = {
        enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
      presets = {
        operators = true,    -- adds help for operators like d, y, ...
        motions = true,      -- adds help for motions
        text_objects = true, -- help for text objects triggered after entering an operator
        windows = true,      -- default bindings on <c-w>
        nav = true,          -- misc bindings to work with windows
        z = true,            -- bindings for folds, spelling and others prefixed with z
        g = true,            -- bindings for prefixed with g
      },
    },
    ---@type wk.Win
    win = {
      -- don't allow the popup to overlap with the cursor
      no_overlap = false,
      -- width = 1,
      -- height = { min = 4, max = 25 },
      -- col = 0,
      -- row = math.huge,
      -- border = "none",
      padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
      title = false,
      title_pos = "center",
      zindex = 1000,
      -- Additional vim.wo and vim.bo options
      bo = {},
      wo = {
        -- winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
      },
    },
    layout = {
      -- width = { min = 20 }, -- min and max width of the columns
      spacing = 3,    -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    keys = {
      scroll_down = "<c-d>", -- binding to scroll down inside the popup
      scroll_up = "<c-u>",   -- binding to scroll up inside the popup
    },
    ---@type (string|wk.Sorter)[]
    --- Add "manual" as the first element to use the order the mappings were registered
    --- Other sorters: "desc"
    sort = { "local", "order", "group", "alphanum", "mod", "lower", "icase" },
    ---@type number|fun(node: wk.Node):boolean?
    expand = 1, -- expand groups when <= n mappings
    -- expand = function(node)
    --   return not node.desc -- expand all nodes without a description
    -- end,
    ---@type table<string, ({[1]:string, [2]:string}|fun(str:string):string)[]>
    replace = {
      key = {
        function(key)
          return require("which-key.view").format(key)
        end,
        -- { "<Space>", "SPC" },
      },
      desc = {
        { "<Plug>%((.*)%)", "%1" },
        { "^%+",            "" },
        { "<[cC]md>",       "" },
        { "<[cC][rR]>",     "" },
        { "<[sS]ilent>",    "" },
        { "^lua%s+",        "" },
        { "^call%s+",       "" },
        { "^:%s*",          "" },
      },
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
      ellipsis = "…",
      --- See `lua/which-key/icons.lua` for more details
      --- Set to `false` to disable keymap icons
      ---@type wk.IconRule[]|false
      rules = false,
      -- use the highlights from mini.icons
      -- When `false`, it will use `WhichKeyIcon` instead
      colors = true,
      -- used by key format
      keys = {
        Up = " ",
        Down = " ",
        Left = " ",
        Right = " ",
        C = "󰘴 ",
        M = "󰘵 ",
        S = "󰘶 ",
        CR = "󰌑 ",
        Esc = "󱊷 ",
        ScrollWheelDown = "󱕐 ",
        ScrollWheelUp = "󱕑 ",
        NL = "󰌑 ",
        BS = "⌫",
        Space = "󱁐 ",
        Tab = "󰌒 ",
      },
    },
    show_help = true, -- show a help message in the command line for using WhichKey
    show_keys = true, -- show the currently pressed key and its label as a message in the command line
    -- Which-key automatically sets up triggers for your mappings.
    -- But you can disable this and setup the triggers yourself.
    -- Be aware, that triggers are not needed for visual and operator pending mode.
    triggers = true, -- automatically setup triggers
    disable = {
      -- disable WhichKey for certain buf types and file types.
      ft = {},
      bt = {},
      -- disable a trigger for a certain context by returning true
      ---@type fun(ctx: { keys: string, mode: string, plugin?: string }):boolean?
      trigger = function(ctx)
        return false
      end,
    },
    debug = false, -- enable wk.log in the current directory
  }
}

function M.setup()
  local status_ok, whichkey = pcall(require, "which-key")
  if not status_ok then
    log:ERROR("Failed to load which-key module.")
    return
  end

  whichkey.setup(dvim.core.which_key.configs)
end

return M
