local M = {}

local log = require("utils.log")

local fn = vim.fn
local marginTopPercent = 0.1
local headerPadding = fn.max({ 2, fn.floor(fn.winheight(0) * marginTopPercent) })
local padding_up = { type = "padding", val = headerPadding }
local padding_down = { type = "padding", val = 2 }

local function version()
  local commit = vim.fn.system({ "git", "-C", dvim_runtime_dir, "rev-parse", "--short", "HEAD" }):gsub("%s+", "")
  return string.format("%s", commit)
end

local function button(sc, txt, keybind)
  local sc_ = sc:gsub("%s", ""):gsub("Space", "<leader>")

  local opts = {
    position = "center",
    text = txt,
    shortcut = sc,
    cursor = 3,
    width = 36,
    align_shortcut = "right",
  }

  if keybind then
    opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
  end

  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true) or ""
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = opts,
  }
end

local header = {
  type = "text",
  val = {
    "",
    "⠀⠀⠀⠀⢀⣤⣶⣾⣿⣿⣿⣷⣶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣴⣾⣿⣿⣿⣿⣶⣤⣀⠀⠀⠀⠀",
    "⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣠⣤⣴⣶⣶⣶⣶⣶⣦⣤⣤⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀",
    "⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡋⠉⠉⠉⠉⠉⠉⠉⠙⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀",
    "⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⠀",
    "⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠀",
    "⠀⠀⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⠀⠀⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀",
    "⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀",
    "⠀⠀⠀⢠⣿⡟⠻⠿⣿⣿⣿⠿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠻⠿⢿⣿⣿⡿⠿⠻⣿⡆⠀⠀⠀",
    "⠀⠀⠀⣾⣿⠀⠀⠀⠀⠀⠀⠀⢠⣤⣤⣤⣤⣤⣀⡀⠀⠀⠀⣤⣤⣤⠀⠀⠀⠀⠀⣤⣤⣤⠀⠀⠀⠀⢿⣿⠀⠀⠀",
    "⠀⠀⢀⣿⡇⠀⠀⠀⠀⠀⠀⠀⣿⣿⡿⠿⠿⢿⣿⣿⣦⠀⠀⣿⣿⣿⠀⠀⠀⠀⣸⣿⣿⠃⠀⠀⠀⠀⢸⣿⡆⠀⠀",
    "⠀⠀⢸⣿⡇⠀⠀⠀⠀⠀⠀⢰⣿⣿⡇⠀⠀⠀⢹⣿⣿⡇⠀⢹⣿⣿⠀⠀⠀⣰⣿⣿⠃⠀⠀⠀⠀⠀⢸⣿⡇⠀⠀",
    "⠀⠀⠘⣿⡇⠀⠀⠀⠀⠀⠀⣼⣿⣿⠀⠀⠀⠀⢸⣿⣿⠇⠀⢸⣿⣿⠀⠀⣰⣿⣿⠃⠀⠀⠀⠀⠀⠀⢸⣿⠇⠀⠀",
    "⠀⠀⠀⢿⣿⠀⠀⠀⠀⠀⢀⣿⣿⡏⠀⠀⠀⠀⣾⣿⡿⠀⠀⠸⣿⣿⡄⢠⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⣾⣿⠀⠀⠀",
    "⠀⠀⠀⠸⣿⣇⠀⠀⠀⠀⢸⣿⣿⠃⠀⠀⣀⣾⣿⡿⠁⠀⠀⠀⣿⣿⣧⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⣰⣿⠇⠀⠀⠀",
    "⠀⠀⠀⠀⠹⣿⣆⠀⠀⠀⣿⣿⣿⣶⣾⣿⣿⡿⠋⠀⠀⠀⠀⠀⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠀⣰⣿⡏⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠙⣿⣧⡀⠀⠉⠉⠉⠉⠉⠉⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⢀⣴⣿⠏⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠈⠻⣿⣦⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣾⡿⠁⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣦⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣴⣿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⢿⣷⣦⣤⣀⣀⣀⠀⠀⠀⢀⣀⣀⣤⣴⣶⣿⠿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠛⠿⠿⠿⠿⠿⠿⠿⠛⠛⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀",
    "",
  },
  opts = {
    position = "center",
  },
}
local buttons = {
  type = "group",
  val = {
    button("Space f n", dvim.icons.ui.new_file .. " New File  ", ":ene <BAR> startinsert <CR>"),
    button("Space s t", dvim.icons.ui.word .. " Find Word  ", ":Telescope live_grep<CR>"),
    button("Space s f", dvim.icons.ui.search .. " Open File ", ":Telescope find_files<CR>"),
    button("Space s r", dvim.icons.ui.recent_file .. " Recent File  ", ":Telescope oldfiles<CR>"),
    button("Space s p", dvim.icons.ui.recent_project .. " Recent Projects", ":Telescope projects <CR>"),
  },
  opts = {
    spacing = 1,
  },
}
local footer = {
  type = "text",
  val = "DomacsVim - " .. version(),
  opts = {
    position = "center",
    hl = "Number",
  },
}

M.defaults = {
  active = true,
  keymappings = {},
  configs = {
    layout = {
      padding_up,
      header,
      padding_down,
      buttons,
      padding_down,
      footer,
    },
  },
}

function M.setup()
  local status_ok, alpha = pcall(require, "alpha")
  if not status_ok then
    log:ERROR("Failed to load alpha module.")
    return
  end

  alpha.setup(dvim.core.dashboard.configs)
end

return M
