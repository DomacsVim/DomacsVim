local M = {}

M.defaults = {
  configs = {
    breakpoint = {
      text = dvim.icons.ui.bug,
      texthl = "DiagnosticSignError",
      linehl = "",
      numhl = "",
    },
    breakpoint_rejected = {
      text = dvim.icons.ui.bug,
      texthl = "DiagnosticSignError",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = dvim.icons.ui.right_select,
      texthl = "DiagnosticSignWarn",
      linehl = "Visual",
      numhl = "DiagnosticSignWarn",
    },
    log = {
      level = "info",
    },
    ui = {
      auto_open = true,
      notify = {
        threshold = vim.log.levels.INFO,
      },
      config = {
        icons = {
          expanded = dvim.icons.ui.buttom_select,
          collapsed = dvim.icons.ui.right_select,
          circular = dvim.icons.ui.circular,
        },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        -- Use this to override mappings for specific elements
        element_mappings = {},
        expand_lines = true,
        layouts = {
          {
            elements = {
              { id = "scopes",      size = 0.33 },
              { id = "breakpoints", size = 0.17 },
              { id = "stacks",      size = 0.25 },
              { id = "watches",     size = 0.25 },
            },
            size = 0.33,
            position = "right",
          },
          {
            elements = {
              { id = "repl",    size = 0.45 },
              { id = "console", size = 0.55 },
            },
            size = 0.27,
            position = "bottom",
          },
        },
        controls = {
          enabled = true,
          -- Display controls in this element
          element = "repl",
          icons = {
            pause = dvim.icons.ui.pause,
            play = dvim.icons.ui.play,
            step_into = dvim.icons.ui.step_into,
            step_over = dvim.icons.ui.step_over,
            step_out = dvim.icons.ui.step_out,
            step_back = dvim.icons.ui.step_back,
            run_last = dvim.icons.ui.run_last,
            terminate = dvim.icons.ui.terminate,
          },
        },
        floating = {
          max_height = 0.9,
          max_width = 0.5, -- Floats will be treated as percentage of your screen.
          border = "rounded",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil, -- Can be integer or nil.
          max_value_lines = 100, -- Can be integer or nil.
        },
      },
    },
  },
}

function M.setup()
  local dap = require("dap")

  vim.fn.sign_define("DapBreakpoint", dvim.core.dap.configs.breakpoint)
  vim.fn.sign_define("DapBreakpointRejected", dvim.core.dap.configs.breakpoint_rejected)
  vim.fn.sign_define("DapStopped", dvim.core.dap.configs.stopped)

  dap.set_log_level(dvim.core.dap.configs.log.level)
end

function M.ui()
  local dap = require("dap")
  local dapui = require("dapui")

  dapui.setup(dvim.core.dap.configs.ui.config)

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

return M
