local M = {}

local log = require("utils.log")

M.defaults = {
  active = true,
  keymappings = {
    normal_mode = {
      ["<C-t>"] = ":ToggleTerm<cr>",
    },
    term_mode = {
      ["<esc>"] = [[<C-\><C-n>]],
      ["<C-h>"] = [[<Cmd>wincmd h<CR>]],
      ["<C-j>"] = [[<Cmd>wincmd j<CR>]],
      ["<C-k>"] = [[<Cmd>wincmd k<CR>]],
      ["<C-l>"] = [[<Cmd>wincmd l<CR>]],
      ["<C-w>"] = [[<C-\><C-n><C-w>]],
    },
  },
  configs = {
    -- size can be a number or function which is passed the current terminal
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    autochdir = false,
    shade_terminals = true,
    start_in_insert = true,
    insert_mappings = true,   -- whether or not the open mapping applies in insert mode
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    persist_size = true,
    persist_mode = true,      -- if set to true (default) the previous terminal mode will be remembered
    direction = "horizontal",
    close_on_exit = true,     -- close the terminal window when the process exits
    -- Change the default shell. Can be a string or a function returning a string
    shell = vim.o.shell,
    auto_scroll = true, -- automatically scroll to the bottom on terminal output
    highlights = {
      Normal = {
        link = "NormalFloat",
      },
      NormalFloat = {
        link = "NormalFloat",
      },
    },
    on_open = function()
      vim.opt.signcolumn = "no"
    end,
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
      -- The border key is *almost* the same as 'nvim_open_win'
      -- see :h nvim_open_win for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      border = "single",
      -- like `size`, width, height, row, and col can be a number or function which is passed the current terminal
      width = 0.7,
      height = 0.7,
      winblend = 3,
    },
    winbar = {
      enabled = false,
      name_formatter = function(term) --  term: Terminal
        return term.name
      end,
    },
  },
}

function M.change_log()
  local Terminal = require("toggleterm.terminal").Terminal
  local change_log = Terminal:new({
    cmd = "git -C " .. dvim_runtime_dir .. " log",
    hidden = true,
    direction = "float",
    float_opts = {
      border = "none",
      width = 100000,
      height = 100000,
    },
  })
  change_log:toggle()
end

function M.lazygit_toggle()
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = "float",
    float_opts = {
      border = "none",
      width = 100000,
      height = 100000,
    },
    on_open = function(_)
      vim.cmd("startinsert!")
    end,
  })
  lazygit:toggle()
end

function M.setup()
  local status_ok, term = pcall(require, "toggleterm")
  if not status_ok then
    log:ERROR("Failed to load toggle-term module.")
    return
  end

  term.setup(dvim.core.terminal.configs)
end

return M
