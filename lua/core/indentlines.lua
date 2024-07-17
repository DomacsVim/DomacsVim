local M = {}

local log = require "utils.log"

M.defaults = {
  active = true,
  keymappings = {},
  configs = {
    enabled = true,
    debounce = 200,
    viewport_buffer = {
      min = 30,
      max = 500,
    },
    indent = {
      char = "▎",
      tab_char = nil,
      highlight = "IblIndent",
      smart_indent_cap = true,
      priority = 1,
      repeat_linebreak = true,
    },
    whitespace = {
      highlight = "IblWhitespace",
      remove_blankline_trail = true,
    },
    scope = {
      enabled = false,
      char = nil,
      show_start = true,
      show_end = true,
      show_exact_scope = false,
      injected_languages = true,
      highlight = "IblScope",
      priority = 1024,
      include = {
        node_type = {},
      },
      exclude = {
        language = {},
        node_type = {
          ["*"] = {
            "source_file",
            "program",
          },
          lua = {
            "chunk",
          },
          python = {
            "module",
          },
        },
      },
    },
    exclude = {
      filetypes = {
        "lspinfo",
        "packer",
        "checkhealth",
        "help",
        "man",
        "gitcommit",
        "TelescopePrompt",
        "TelescopeResults",
        "",
      },
      buftypes = {
        "terminal",
        "nofile",
        "quickfix",
        "prompt",
      },
    },
  },
}

function M.setup()
  local status_ok, indentlines = pcall(require, "ibl")
  if not status_ok then
    log:ERROR "Failed to load indent_blank_lines module."
    return
  end

  indentlines.setup(dvim.core.indentlines.configs)
end

return M
