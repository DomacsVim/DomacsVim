local M = {}

function M.devicons()
  local _, themer = pcall(function() return require("themer").get_theme_table().hex end)

  return {
    c = {
      icon = "",
      name = "c",
      color = themer.blue
    },

    css = {
      icon = "",
      name = "css",
      color = themer.blue
    },

    deb = {
      icon = "",
      name = "deb",
      color = themer.red
    },

    Dockerfile = {
      icon = "",
      name = "Dockerfile",
      color = themer.blue
    },

    html = {
      icon = "",
      name = "html",
      color = themer.red
    },

    jpeg = {
      icon = "󰉏",
      name = "jpeg",
      color = themer.yellow
    },

    jpg = {
      icon = "󰉏",
      name = "jpg",
      color = themer.yellow
    },

    js = {
      icon = "󰌞",
      name = "js",
      color = themer.yellow
    },

    kt = {
      icon = "󱈙",
      name = "kt",
      color = themer.purple
    },

    lock = {
      icon = "󰌾",
      name = "lock",
      color = themer.red
    },

    lua = {
      icon = "",
      name = "lua",
      color = themer.blue
    },

    mp3 = {
      icon = "󰎆",
      name = "mp3",
      color = themer.purple
    },

    mp4 = {
      icon = "",
      name = "mp4",
      color = themer.purple
    },

    out = {
      icon = "",
      name = "out",
      color = themer.green
    },

    png = {
      icon = "󰉏",
      name = "png",
      color = themer.yellow
    },

    py = {
      icon = "",
      name = "py",
      color = themer.yellow
    },

    ["robots.txt"] = {
      icon = "󰚩",
      name = "robots",
      color = themer.orange
    },

    toml = {
      icon = "",
      name = "toml",
      color = themer.blue
    },

    ts = {
      icon = "󰛦",
      name = "ts",
      color = themer.blue
    },

    ttf = {
      icon = "",
      name = "TrueTypeFont",
      color = themer.orange
    },

    rb = {
      icon = "",
      name = "rb",
      color = themer.red
    },

    rpm = {
      icon = "",
      name = "rpm",
      color = themer.red
    },

    vue = {
      icon = "󰡄",
      name = "vue",
      color = themer.green
    },

    woff = {
      icon = "",
      name = "WebOpenFontFormat",
      color = themer.orange
    },

    woff2 = {
      icon = "",
      name = "WebOpenFontFormat2",
      color = themer.orange
    },

    xz = {
      icon = "",
      name = "xz",
      color = themer.cyan
    },

    zip = {
      icon = "",
      name = "zip",
      color = themer.cyan
    },
  }
end

M.ui = {
  breadcrumb = "󰄾 ",
  separator = " ",
  search = " ",
  right_arrow = " > ",
  left_arrow = " < ",
  check = " ",
  pending = " ",
  fail = " ",
  left_side = "▎",
  new_file = " ",
  word = " ",
  recent_file = " ",
  recent_project = " ",
  bug = " ",
  right_select = "",
  buttom_select = "",
  circular = "",
  pause = "",
  play = "",
  step_into = "",
  step_over = "",
  step_out = "",
  step_back = "",
  run_last = "",
  terminate = "",
}

return M
