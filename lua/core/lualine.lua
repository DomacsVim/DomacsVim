local M = {}

local utils = require("utils.modules")

local function system()
  local system_name = ""
  return {
    function()
      local icon
      if vim.loop.os_uname().sysname == "Linux" then
        if utils.is_file("/etc/arch-release") or utils.is_file("/etc/artix-release") then
          icon = "%#StatusLineArchLinux#" .. "  "
          system_name = "ArchLinux"
        elseif utils.is_file("/etc/fedora-release") or utils.is_file("/etc/redhat-release") then
          icon = "%#StatusLineFedoraLinux#" .. "  "
          system_name = "FedoraLinux"
        elseif utils.is_file("/etc/SuSE-release") then
          icon = "%#StatusLineSuseLinux#" .. "  "
          system_name = "SuSELinux"
        else
          icon = "%#StatusLineUbuntuLinux#" .. "  "
          system_name = "LinuxDebian or based on"
        end
      elseif
        vim.loop.os_uname().sysname == "FreeBSD"
        or vim.loop.os_uname().sysname == "NetBSD"
        or vim.loop.os_uname().sysname == "OpenBSD"
      then
        icon = "%#StatusLineBSD#" .. "  "
      elseif vim.loop.os_uname().sysname == "Darwin" then
        icon = "%#StatusLineDarwin#" .. "  "
      end
      return icon
    end,
    on_click = function()
      print(system_name)
    end
  }
end

local function branch()
  return {
    "branch",
    color = "StatusLinegitIcons",
    separator = { right = dvim.core.lualine.configs.options.section_separators.left},
    on_click = function()
      vim.cmd("Telescope git_commits")
    end
  }
end

local function mode()
  return {
    "mode",
    color = "StatusLineModes",
    separator = { right = dvim.core.lualine.configs.options.section_separators.left}
  }
end

local function diff()
  return {
    "diff",
    color = "StatusLineDiffIcons",
    separator = { right = dvim.core.lualine.configs.options.section_separators.left},
    on_click = function()
      vim.cmd("Telescope git_status")
    end
  }
end

local function diagnostics()
  return {
    "diagnostics",
    diagnostics_color = {
      error = 'StatusLinelspError',
      warn  = 'StatusLinelspWarning',
      info  = 'StatusLinelspInfo',
      hint  = 'StatusLinelspHints',
    },
    on_click = function()
      vim.cmd("Telescope diagnostics")
    end
  }
end

local function filename()
  return {
    'filename',
    color = "StatusLineFileInfo",
    file_status = true,      -- Displays file status (readonly status, modified status)
    newfile_status = true,  -- Display new file status (new file means no write after created)
    shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
    symbols = {
      modified = '[+]',      -- Text to show when the file is modified.
      readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
      unnamed = '[No Name]', -- Text to show for unnamed buffers.
      newfile = '[New]',     -- Text to show for newly created file before first write
    },
    on_click = function()
      vim.cmd("Telescope file_browser")
    end
  }
end

local function tabsize()
  return {
    function()
      return string.format("TabSize: %s", vim.opt.tabstop["_value"])
    end,
    on_click = function()
      local TSize = vim.fn.input("Enter TabSize : ")
      vim.opt.tabstop = tonumber(TSize)
    end
  }
end

local function filetype()
  return {
    "filetype",
    color = "StatusLineFTIcons",
    separator = { left = dvim.core.lualine.configs.options.section_separators.right},
    on_click = function()
      vim.cmd("Telescope filetypes")
    end
  }
end

local function lsp()
  return {
    function()
      local buf_client_names = {}
      if rawget(vim, "lsp") then
        ---@diagnostic disable-next-line: deprecated
        for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
          if client.attached_buffers[vim.api.nvim_get_current_buf()] then
            table.insert(buf_client_names, client.name)
          end
        end
        local unique_client_names = table.concat(buf_client_names, ", ")
        local language_servers = string.format("%s", unique_client_names)
        return (vim.o.columns > 100 and "%#StatusLineLspStatusSep#" .. dvim.core.lualine.configs.options.section_separators.right .. "%#StatusLineLspStatus#   [" .. language_servers .. "] ")
          or "   [] "
      end
    end,
    padding = 0
  }
end

local function encoding()
  return {
    "encoding",
    color = "StatusLineEncodingIcons",
    separator = { right = dvim.core.lualine.configs.options.component_separators.left, left = dvim.core.lualine.configs.options.section_separators.right },
  }
end

-- VirtualEnv
local function env_cleanup(venv)
  if string.find(venv, "/") then
    local final_venv = venv
    for w in venv:gmatch("([^/]+)") do
      final_venv = w
    end
    venv = final_venv
  end
  return venv
end

local function python_venv()
  if vim.bo.filetype == "python" then
    local venv = os.getenv("CONDA_DEFAULT_ENV")
    if venv then
      return "%#StatusLinePythonVenv# (" .. env_cleanup(venv) .. ")"
    end
    venv = os.getenv("VIRTUAL_ENV")
    if venv then
      return "%#StatusLinePythonVenv# (" .. env_cleanup(venv) .. ")"
    end
    return ""
  end
  return ""
end

-- Npm
local function npm()
  if utils.is_file("./package.json") then
    return "%#StatusLineNpm# Nodejs"
  else
    return ""
  end
end

M.defaults = {
  configs = {
    options = {
      icons_enabled = true,
      theme = {
        normal = {link = "StatusLine"}
      },
      component_separators = { left = '', right = ''},
      section_separators = { left = '', right = ''},
      disabled_filetypes = { "alpha", "NvimTree" },
      always_divide_middle = false,
      globalstatus = true,
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      }
    },
    sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
  }
}

function M.setup()
  local status_ok, lualine = pcall(require, "lualine")
  if not status_ok then
    return
  end

  dvim.core.lualine.configs.sections = vim.tbl_extend("keep", {
      lualine_a = {system()},
      lualine_b = {},
      lualine_c = {branch(), diff(), mode(), diagnostics(), filename(), python_venv(), npm()},
      lualine_x = {"location", tabsize(), lsp(), encoding(), filetype()},
      lualine_y = {},
      lualine_z = {}
  }, dvim.core.lualine.configs.sections)

  lualine.setup(dvim.core.lualine.configs)
end

return M
