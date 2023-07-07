dvim.core.whichkey = {
  setup = {
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "  ", -- symbol used between a key and it's label
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
      spacing = 6, -- spacing between columns
    },
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      i = { "j", "k" },
      v = { "j", "k" },
    }
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
  vmappings = {
    ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
  },
  mappings = {
    ["n"] = { "<esc><cmd> edit Untitled-File <cr>", "New File" },
    ["c"] = { "<cmd>bw<cr>", "Close Buffer" },
    ["f"] = { "<cmd>Telescope find_files<cr>", "Find Files" },
    ["b"] = { "<cmd>Telescope file_browser<cr>", "File Browser" },
    ["w"] = { "<cmd>w!<cr>", "Save" },
    ["W"] = { "<cmd>wa!<cr>", "Save All" },
    ["S"] = { "<cmd>edit " .. dvim_config_dir .. "/init.lua<cr>", "Preferences" },
    ["u"] = { "<cmd>undo<cr>", "Undo" },
    ["r"] = { "<cmd>redo<cr>", "Redo" },
    ["a"] = { "ggVG", "Select All" },
    ["C"] = { "ggVGy", "Copy All" },
    ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comment" },
    ["k"] = { "<cmd>m .-2<CR>==", "Move Line Up" },
    ["j"] = { "<cmd>m .+1<CR>==<cr>", "Move Line Down" },
    ["`"] = { "<cmd>Telescope commands<cr>", "Commands" },
    ["B"] = {
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
      n = { "<cmd>lua _NODE_TOGGLE()<CR>", "Node" },
      u = { "<cmd>lua _NCDU_TOGGLE()<CR>", "NCDU" },
      t = { "<cmd>lua _HTOP_TOGGLE()<CR>", "Htop" },
      p = { "<cmd>lua _PYTHON_TOGGLE()<CR>", "Python" },
      f = { "<cmd>ToggleTerm direction=float<CR>", "Float" },
      h = { "<cmd>ToggleTerm size=10 direction=horizontal<CR>", "Horizontal" },
      v = { "<cmd>ToggleTerm size=80 direction=vertical<CR>", "Vertical" },
    },
    ["P"] = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
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
    ["s"] = {
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
      p = { "<cmd>Telescope projects<cr>", "Recent Project" },
    },
  },
}

return dvim.core.whichkey
