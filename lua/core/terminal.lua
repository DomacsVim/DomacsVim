local M = {}

local editor_layout = {
  height = vim.o.lines - vim.o.cmdheight - 2,
  width = vim.o.columns,
}

function M.config()
  dvim.core.terminal = {
    size = 15,
    open_mapping = nil,
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = false,
    -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
    direction = "horizontal",
    close_on_exit = true, -- close the terminal window when the process exits
    shell = nil, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    highlights = {
      NormalFloat = {
        link = "NormalFloat",
      },
      FloatBorder = {
        link = "FloatBorder",
      },
    },
    float_opts = {
      -- The border key is *almost* the same as 'nvim_win_open'
      -- see :h nvim_win_open for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      width = math.floor(editor_layout.width * 0.8),
      height = math.floor(editor_layout.height * 0.73),
      border = "single",
      winblend = 0,
    },
  }
end

function M.setup()
  require("toggleterm").setup(dvim.core.terminal)
end

return M
