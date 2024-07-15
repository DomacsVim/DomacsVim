local M = {}

function M.welcome()
  if vim.bo.filetype ~= "alpha" then
    vim.cmd("Alpha")
  end
end

function M.show_all_commands()
  vim.cmd("Telescope commands")
end

function M.documentation()
  -- TODO: I will create a documentation for domacsvim
  vim.fn.system("xdg-open https://gitlab.com/domacsvim/domacsvim")
end

function M.keyboard_shortcuts_reference()
  vim.cmd("Telescope keymaps")
end

function M.report_issue()
  vim.fn.system("xdg-open https://gitlab.com/domacsvim/domacsvim/-/issues/new")
end

function M.view_license()
  vim.fn.system("xdg-open https://gitlab.com/domacsvim/domacsvim/-/blob/main/LICENSE")
end

function M.about()
  local editor_layout = {
    height = vim.o.lines - vim.o.cmdheight - 2, -- Add margin for status and buffer line
    width = vim.o.columns,
  }
  local popup_layout = {
    relative = "editor",
    height = math.floor(editor_layout.height * 0.37),
    width = math.floor(editor_layout.width * 0.4),
    style = "minimal",
    border = "rounded",
  }
  popup_layout.row = math.floor((editor_layout.height - popup_layout.height) / 2)
  popup_layout.col = math.floor((editor_layout.width - popup_layout.width) / 2)

  local function center_text(text)
    if type(text) == "string" then
      local width = (popup_layout.width - text:len()) / 2
      return string.rep(" ", width) .. text
    end
  end

  local function version()
    local commit = vim.fn.system({ "git", "-C", dvim_runtime_dir, "rev-parse", "--short", "HEAD" }):gsub("%s+", "")
    return string.format("%s", commit)
  end

  local function line()
    local width = popup_layout.width - 3
    return string.rep("", width)
  end

  local lines = {
    center_text("DomacsVim"),
    "",
    " Version : " ..
    vim.fn.system("echo $(git -C " .. dvim_runtime_dir .. " rev-parse --abbrev-ref HEAD)"):gsub("%s+", ""),
    " Commit  : " .. version(),
    " Date    : " .. string.format(
      "%s",
      vim.fn.system("echo $(git -C " .. dvim_runtime_dir .. " log -1 --format=%cd)"):gsub("%s+", "")
    ),
    " OS      : " .. string.format("%s", vim.fn.system("uname -srm"):gsub("%s+", "")),
    " Nvim    : "
    .. string.format("%s", vim.fn.system("nvim --version | grep -oP '(?<=^NVIM v)[0-9|.]+'"):gsub("%s+", "")),
    " Luajit  : "
    .. string.format("%s", vim.fn.system("nvim --version | grep -oP '(?<=^LuaJIT).*'"):gsub("%s+", "")),
    " Lua rel : " .. string.format("%s", vim.fn.system("lua -v | grep -oP '(?<=^Lua )[0-9|.]+'"):gsub("%s+", "")),
    "",
    " " .. line(),
    "",
    center_text("GNU AFFERO GENERAL PUBLIC LICENSE"),
    center_text("Version 3, 19 November 2007"),
    "",
    center_text("Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>"),
    center_text("Everyone is permitted to copy and distribute verbatim copies"),
    center_text("of this license document, but changing it is not allowed."),
  }

  local buffer = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_open_win(buffer, true, popup_layout)
  vim.api.nvim_buf_set_lines(buffer, 0, -1, false, lines)

  vim.cmd([[highlight Header gui=bold]])
  vim.fn.matchadd("Header", "DomacsVim")
end

return M
