local M = {}

M.defaults = {
  active = true,
  keymappings = {
    normal_mode = {
      ["<C-/>"] = function() require("Comment.api").toggle.linewise.current() end
    },
    visual_mode = {
      ["<C-/>"] = "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>"
    }
  },
  configs = {
    padding = true,

    ---Whether cursor should stay at the
    ---same position. Only works in NORMAL
    ---mode mappings
    sticky = true,

    ---Lines to be ignored while comment/uncomment.
    ---Could be a regex string or a function that returns a regex string.
    ---Example: Use '^$' to ignore empty lines
    ---@type string|function
    ignore = "^$",

    ---Whether to create basic (operator-pending) and extra mappings for NORMAL/VISUAL mode
    ---@type table
    mappings = {
      ---operator-pending mapping
      ---Includes `gcc`, `gcb`, `gc[count]{motion}` and `gb[count]{motion}`
      basic = false,
      ---Extra mapping
      extra = false,
    },
  }
}

function M.setup()
  local status_ok, comment = pcall(require, "Comment")
  if not status_ok then
    log:ERROR("Failed to load Comment module.")
    return
  end
  comment.setup(dvim.core.comment.configs)
end

return M
