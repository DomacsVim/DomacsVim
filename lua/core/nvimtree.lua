local M = {}

local log = require("utils.log")

-- default configurations
M.defaults = {
  active = true,
  keymappings = {
    normal_mode = {
      ["<C-S-e>"] = ":NvimTreeToggle<CR>"
    }
  },
  configs = {
    auto_reload_on_write = true,
    disable_netrw = true,
    hijack_cursor = true,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,
    sort_by = "name",
    root_dirs = {},
    prefer_startup_root = false,
    sync_root_with_cwd = true,
    reload_on_bufenter = false,
    respect_buf_cwd = false,
    on_attach = "disable",
    select_prompts = false,
    view = {
      adaptive_size = false,
      centralize_selection = false,
      width = 31,
      side = "left",
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = "yes",
      float = {
        enable = false,
        quit_on_focus_loss = true,
        open_win_config = {
          relative = "editor",
          border = "rounded",
          width = 31,
          height = 31,
          row = 1,
          col = 1,
        },
      },
    },
    renderer = {
      add_trailing = false,
      group_empty = false,
      highlight_git = true,
      full_name = false,
      highlight_opened_files = "none",
      root_folder_label = false,
      indent_width = 2,
      indent_markers = {
        enable = false,
        inline_arrows = true,
      },
      icons = {
        webdev_colors = true,
        git_placement = "before",
        modified_placement = "after",
        padding = " ",
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
          modified = true,
        },
        glyphs = {
          git = {
            unstaged = "",
            staged = "",
            unmerged = "",
            renamed = "",
            untracked = "",
            deleted = "",
            ignored = "",
          },
        },
      },
      special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
      symlink_destination = true,
    },
    hijack_directories = {
      enable = false,
      auto_open = true,
    },
    update_focused_file = {
      enable = true,
      debounce_delay = 15,
      update_root = true,
      ignore_list = {},
    },
    filters = {
      dotfiles = false,
      git_clean = false,
      no_buffer = false,
      custom = { "node_modules", "\\.cache" },
      exclude = {},
    },
    filesystem_watchers = {
      enable = true,
      debounce_delay = 50,
      ignore_dirs = {},
    },
    git = {
      enable = true,
      ignore = false,
      show_on_dirs = true,
      show_on_open_dirs = true,
      timeout = 200,
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = true,
        global = false,
        restrict_above_cwd = false,
      },
      expand_all = {
        max_folder_discovery = 300,
        exclude = {},
      },
      file_popup = {
        open_win_config = {
          col = 1,
          row = 1,
          relative = "cursor",
          border = "shadow",
          style = "minimal",
        },
      },
      open_file = {
        quit_on_open = false,
        resize_window = false,
        window_picker = {
          enable = true,
          picker = "default",
          chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
          exclude = {
            filetype = { "notify", "qf", "diff", "fugitive", "fugitiveblame" },
            buftype = { "nofile", "terminal", "help" },
          },
        },
      },
      remove_file = {
        close_window = true,
      },
    },
    trash = {
      cmd = "trash",
      require_confirm = true,
    },
    live_filter = {
      prefix = "[FILTER]: ",
      always_show_folders = true,
    },
    tab = {
      sync = {
        open = false,
        close = false,
        ignore = {},
      },
    },
    notify = {
      threshold = vim.log.levels.INFO,
    },
    log = {
      enable = false,
      truncate = false,
      types = {
        all = false,
        config = false,
        copy_paste = false,
        dev = false,
        diagnostics = false,
        git = false,
        profile = false,
        watcher = false,
      },
    },
    system_open = {
      cmd = nil,
      args = {},
    }
  }
}

function M.setup()
  local status_ok, nvimtree = pcall(require, "nvim-tree")
  if not status_ok then
    log:ERROR("Failed to load nvim-tree module.")
    return
  end

  nvimtree.setup(dvim.core.nvimtree.configs)
end

return M
