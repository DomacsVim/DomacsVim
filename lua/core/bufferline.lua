local M = {}

local function exec_toggle(opts)
  local Terminal = require("toggleterm.terminal").Terminal
  local term = Terminal:new { cmd = opts.cmd, count = opts.count, direction = opts.direction }
  term:toggle(opts.size, opts.direction)
end

function M.pull()
  exec_toggle({cmd = "echo 'Receiving the latest changes. Please wait...' && git fetch --recurse-submodules --tags --force --progress && echo 'Done.'"})
end

function M.commit()
  local file = vim.fn.expand('%:p')
  local message = string.format("%s", vim.fn.input("Enter Commit Message: "))
  if file and message then
    vim.fn.system("git add " .. file .. " && git commit -m '" .. message .. "'")
  end
end

function M.push()
  local remote = string.format("%s", vim.fn.system("git remote"):gsub("%s+", ""))
  local branch = vim.fn.system({ "git", "rev-parse", "--abbrev-ref", "HEAD" }):gsub("%s+", "")
  exec_toggle({cmd = "echo 'Pushing the latest changes...' && git push -u " .. remote .. " " .. branch})
end

vim.cmd "function! TbOpen_settings(a,b,c,d) \n edit ~/.config/dvim/init.lua \n endfunction"
vim.cmd "function! TbToggle_search(a,b,c,d) \n Telescope live_grep \n endfunction"
vim.cmd "function! TbToggle_debuging(a,b,c,d) \n lua print('We are working on this new feature...') \n endfunction"
vim.cmd "function! GitPull(a,b,c,d) \n lua require('core.bufferline').pull() \n endfunction"
vim.cmd "function! GitCommit(a,b,c,d) \n lua require('core.bufferline').commit() \n endfunction"
vim.cmd "function! GitPush(a,b,c,d) \n lua require('core.bufferline').push() \n endfunction"

local function is_ft(b, ft)
  return vim.bo[b].filetype == ft
end

local function diagnostics_indicator(_, _, diagnostics, _)
  local result = {}
  local symbols = {
    error = "",
    warning = "",
    info = "",
  }
  for name, count in pairs(diagnostics) do
    if symbols[name] and count > 0 then
      table.insert(result, symbols[name] .. " " .. count)
    end
  end
  result = table.concat(result, " ")
  return #result > 0 and result or ""
end

local function custom_filter(buf, buf_nums)
  local logs = vim.tbl_filter(function(b)
    return is_ft(b, "log")
  end, buf_nums or {})
  if vim.tbl_isempty(logs) then
    return true
  end
  local tab_num = vim.fn.tabpagenr()
  local last_tab = vim.fn.tabpagenr("$")
  local is_log = is_ft(buf, "log")
  if last_tab == 1 then
    return true
  end
  -- only show log buffers in secondary tabs
  return (tab_num == last_tab and is_log) or (tab_num ~= last_tab and not is_log)
end

function M.config()
  dvim.core.bufferline = {
    highlights = {
      background = {
        fg = {
          attribute = "fg",
          highlight = "BufBg"
        },
        bg = {
          attribute = "bg",
          highlight = "BufBg"
        },
        bold = true
      },
      separator = {
        fg = {
          attribute = "fg",
          highlight = "BufSep"
        },
        bg = {
          attribute = "bg",
          highlight = "BufSep"
        },
      },
      fill = {
        bg = {
          attribute = "bg",
          highlight = "BufFilll"
        }
      },
      modified = {
        fg = {
          attribute = "fg",
          highlight = "BufFill"
        },
        bg = {
          attribute = "bg",
          highlight = "BufFill"
        },
      },
      buffer_visible = {
        fg = {
          attribute = "fg",
          highlight = "BufFill"
        },
        bg = {
          attribute = "bg",
          highlight = "BufFill"
        },
      },
      separator_visible = {
        fg = {
          attribute = "fg",
          highlight = "BufFill"
        },
      },
      close_button = {
        fg = {
          attribute = "fg",
          highlight = "BufBg"
        },
        bg = {
          attribute = "bg",
          highlight = "BufBg"
        },
      },
      close_button_visible = {
        fg = {
          attribute = "fg",
          highlight = "BufFill"
        },
        bg = {
          attribute = "bg",
          highlight = "BufFill"
        },
      },
      diagnostic_visible = {
        fg = {
          attribute = "fg",
          highlight = "BufFill"
        },
        bg = {
          attribute = "bg",
          highlight = "BufFill"
        },
      },
      hint_visible = {
        fg = {
          attribute = "fg",
          highlight = "BufFill"
        },
        bg = {
          attribute = "bg",
          highlight = "BufFill"
        },
      },
      hint_diagnostic_visible = {
        fg = {
          attribute = "fg",
          highlight = "BufFill"
        },
        bg = {
          attribute = "bg",
          highlight = "BufFill"
        },
      },
      info_visible = {
        fg = {
          attribute = "fg",
          highlight = "BufFill"
        },
        bg = {
          attribute = "bg",
          highlight = "BufFill"
        },
      },
      info_diagnostic_visible = {
        fg = {
          attribute = "fg",
          highlight = "BufFill"
        },
        bg = {
          attribute = "bg",
          highlight = "BufFill"
        },
      },
      warning_visible = {
        fg = {
          attribute = "fg",
          highlight = "BufFill"
        },
        bg = {
          attribute = "bg",
          highlight = "BufFill"
        },
      },
      warning_diagnostic_visible = {
        fg = {
          attribute = "fg",
          highlight = "BufFill"
        },
        bg = {
          attribute = "bg",
          highlight = "BufFill"
        },
      },
      error_visible = {
        fg = {
          attribute = "fg",
          highlight = "BufFill"
        },
        bg = {
          attribute = "bg",
          highlight = "BufFill"
        },
      },
      error_diagnostic_visible = {
        fg = {
          attribute = "fg",
          highlight = "BufFill"
        },
        bg = {
          attribute = "fg",
          highlight = "BufFill"
        },
      },
      modified_visible = {
        fg = {
          attribute = "fg",
          highlight = "BufFill"
        },
        bg = {
          attribute = "fg",
          highlight = "BufFill"
        },
      },
      duplicate_visible = {
        fg = {
          attribute = "fg",
          highlight = "BufFill"
        },
        bg = {
          attribute = "bg",
          highlight = "BufFill"
        },
        italic = true,
      },
    },
    options = {
      mode = "buffers", -- set to "tabs" to only show tabpages instead
      numbers = "none", -- can be "none" | "ordinal" | "buffer_id" | "both" | function
      close_command = function(bufnr) -- can be a string | function, see "Mouse actions"
        M.buf_kill("bd", bufnr, false)
      end,
      right_mouse_command = "vert sbuffer %d", -- can be a string | function, see "Mouse actions"
      left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
      middle_mouse_command = "enew", -- can be a string | function, see "Mouse actions"
      indicator = {
        icon = "▎",
        style = "icon"
      },
      buffer_close_icon = "󰅖",
      modified_icon = "",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      --- name_formatter can be used to change the buffer's label in the bufferline.
      --- Please note some names can/will break the
      --- bufferline so use this at your discretion knowing that it has
      --- some limitations that will *NOT* be fixed.
      name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
        -- remove extension from markdown files for example
        if buf.name:match("%.md") then
          return vim.fn.fnamemodify(buf.name, ":t:r")
        end
      end,
      custom_areas = {
        right = function()
          local result = {}
          if vim.b.gitsigns_head then
            table.insert(result, {text = " Git: %@GitPull@%#Gitpull#󰁂  "})
            local git_status = vim.b.gitsigns_status_dict
            if git_status.added ~= 0 or git_status.changed ~= 0 or git_status.removed ~= 0 then
              table.insert(result, {text = "%@GitCommit@%#Gitcommit#󰄬  "})
            end
            table.insert(result, {text = "%@GitPush@%#Gitpush#󰁜  "})
          end

          if rawget(vim, "lsp") then
            for _, client in ipairs(vim.lsp.get_active_clients()) do
              if client.attached_buffers[vim.api.nvim_get_current_buf()] then
                table.insert(result, {text = "%@TbToggle_debuging@%#Debuging#   "})
              end
            end
          end
          table.insert(result, {text = "%@TbToggle_search@   "})
          table.insert(result, {text = "%@TbOpen_settings@   "})
          return result
        end,
      },
      max_name_length = 18,
      max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
      truncate_names = true, -- whether or not tab names should be truncated
      tab_size = 18,
      diagnostics = "",
      diagnostics_update_in_insert = false,
      diagnostics_indicator = diagnostics_indicator,
      -- NOTE: this will be called a lot so don't do any heavy processing here
      custom_filter = custom_filter,
      offsets = {
        {
          filetype = "undotree",
          text = "Undotree",
          highlight = "PanelHeading",
          padding = 1,
        },
        {
          filetype = "NvimTree",
          text = "Explorer",
          highlight = "PanelHeading",
          padding = 1,
        },
        {
          filetype = "DiffviewFiles",
          text = "Diff View",
          highlight = "PanelHeading",
          padding = 1,
        },
        {
          filetype = "flutterToolsOutline",
          text = "Flutter Outline",
          highlight = "PanelHeading",
        },
        {
          filetype = "lazy",
          text = "Lazy",
          highlight = "PanelHeading",
          padding = 1,
        },
      },
      color_icons = true, -- whether or not to add the filetype icon highlights
      show_buffer_icons = true, -- disable filetype icons for buffers
      show_buffer_close_icons = true,
      show_close_icon = false,
      show_tab_indicators = true,
      persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
      -- can also be a table containing 2 custom separators
      -- [focused and unfocused]. eg: { '|', '|' }
      separator_style = "thin",
      enforce_regular_tabs = false,
      always_show_bufferline = true,
      hover = {
        enabled = false, -- requires nvim 0.8+
        delay = 200,
        reveal = { "close" },
      },
      sort_by = "id",
    },
  }
end

function M.buf_kill(kill_command, bufnr, force)
  kill_command = kill_command or "bd"

  local bo = vim.bo
  local api = vim.api
  local fmt = string.format
  local fn = vim.fn

  if bufnr == 0 or bufnr == nil then
    bufnr = api.nvim_get_current_buf()
  end

  local bufname = api.nvim_buf_get_name(bufnr)

  if not force then
    local choice
    if bo[bufnr].modified then
      choice = fn.confirm(fmt([[Save changes to "%s"?]], bufname), "&Yes\n&No\n&Cancel")
      if choice == 1 then
        vim.api.nvim_buf_call(bufnr, function()
          vim.cmd("w")
        end)
      elseif choice == 2 then
        force = true
      else return
      end
    elseif api.nvim_buf_get_option(bufnr, "buftype") == "terminal" then
      choice = fn.confirm(fmt([[Close "%s"?]], bufname), "&Yes\n&No\n&Cancel")
      if choice == 1 then
        force = true
      else
        return
      end
    end
  end

  -- Get list of windows IDs with the buffer to close
  local windows = vim.tbl_filter(function(win)
    return api.nvim_win_get_buf(win) == bufnr
  end, api.nvim_list_wins())

  if force then
    kill_command = kill_command .. "!"
  end

  -- Get list of active buffers
  local buffers = vim.tbl_filter(function(buf)
    return api.nvim_buf_is_valid(buf) and bo[buf].buflisted
  end, api.nvim_list_bufs())

  -- If there is only one buffer (which has to be the current one), vim will
  -- create a new buffer on :bd.
  -- For more than one buffer, pick the previous buffer (wrapping around if necessary)
  if #buffers > 1 and #windows > 0 then
    for i, v in ipairs(buffers) do
      if v == bufnr then
        local prev_buf_idx = i == 1 and #buffers or (i - 1)
        local prev_buffer = buffers[prev_buf_idx]
        for _, win in ipairs(windows) do
          api.nvim_win_set_buf(win, prev_buffer)
        end
      end
    end
  end

  -- Check if buffer still exists, to ensure the target buffer wasn't killed
  -- due to options like bufhidden=wipe.
  if api.nvim_buf_is_valid(bufnr) and bo[bufnr].buflisted then
    vim.cmd(string.format("%s %d", kill_command, bufnr))
  end
end

function M.setup()
  -- vim.opt.showtabline = 2

  require("bufferline").setup(dvim.core.bufferline)
end

return M
