local M = {}

local utils = require "utils.modules"
local log = require "utils.log"

-- lazy configuration
dvim.lazy = {
  root = utils.join_paths(vim.fn.stdpath "data", "lazy"), -- directory where plugins will be installed
  defaults = {
    lazy = true, -- should plugins be lazy-loaded?
    version = nil,
    -- default `cond` you can use to globally disable a lot of plugins
    -- when running inside vscode for example
    ---@diagnostic disable-next-line: undefined-doc-name
    cond = nil, ---@type boolean|fun(self:LazyPlugin):boolean|nil
    -- version = "*", -- enable this to try installing the latest stable versions of plugins
  },
  -- leave nil when passing the spec as the first argument to setup()
  ---@diagnostic disable-next-line: undefined-doc-name
  spec = nil, ---@type LazySpec
  lockfile = utils.join_paths(vim.fn.stdpath "config", "lazy-lock.json"), -- lockfile generated after running update.
  concurrency = jit.os:find "Windows" and (vim.loop.available_parallelism() * 2) or nil,
  git = {
    -- defaults for the `Lazy log` command
    -- log = { "-10" }, -- show the last 10 commits
    log = { "-10" }, -- show commits from the last 3 days
    timeout = 120, -- kill processes that take more than 2 minutes
    url_format = "%s.git",
    -- lazy.nvim requires git >=2.19.0. If you really want to use lazy with an older version,
    -- then set the below to false. This should work, but is NOT supported and will
    -- increase downloads a lot.
    filter = true,
  },
  dev = {
    -- directory where you store your local plugin projects
    path = "~/projects",
    patterns = {}, -- For example {"folke"}
    fallback = false, -- Fallback to git when local plugin doesn't exist
  },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { dvim.colorscheme },
  },
  ui = {
    -- a number <1 is a percentage., >1 is a fixed size
    size = { width = 0.7, height = 0.7 },
    wrap = true, -- wrap the lines in the ui
    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "rounded",
    title = "Lazy", ---@type string only works when border is not "none"
    title_pos = "center", ---@type "center" | "left" | "right"
    -- Show pills on top of the Lazy window
    pills = true, ---@type boolean
    icons = {
      ft = "",
      lazy = "󰂠 ",
      loaded = "",
      not_loaded = "",
    },
    -- leave nil, to automatically select a browser depending on your OS.
    -- If you want to use a specific browser, you can define it here
    browser = nil, ---@type string?
    throttle = 20, -- how frequently should the ui process render events
    custom_keys = {},
  },
  diff = {
    -- diff command <d> can be one of:
    -- * browser: opens the github compare view. Note that this is always mapped to <K> as well,
    --   so you can have a different command for diff <d>
    -- * git: will run git diff and open a buffer with filetype git
    -- * terminal_git: will open a pseudo terminal with git diff
    -- * diffview.nvim: will open Diffview to show the diff
    cmd = "git",
  },
  checker = {
    -- automatically check for plugin updates
    enabled = false,
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = true, -- get a notification when new updates are found
    frequency = 3600, -- check for updates every hour
    check_pinned = false, -- check for pinned packages that can't be updated
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = true, -- get a notification when changes are found
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      reset = false, -- reset the runtime path to $VIMRUNTIME and your config directory
      ---@type string[]
      paths = {}, -- add any custom paths here that you want to includes in the rtp
      ---@type string[] list any plugins you want to disable here
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
  -- lazy can generate helptags from the headings in markdown readme files,
  -- so :help works even for plugins that don't have vim docs.
  -- when the readme opens with :help it will be correctly displayed as markdown
  readme = {
    enabled = true,
    root = utils.join_paths(vim.fn.stdpath "state", "lazy", "readme"),
    files = { "README.md", utils.join_paths("lua", "**", "README.md") },
    -- only generate markdown helptags for plugins that dont have docs
    skip_if_doc_exists = true,
  },
  state = utils.join_paths(vim.fn.stdpath "state", "lazy", "state.json"), -- state info for checker and other things
  build = {
    -- Plugins can provide a `build.lua` file that will be executed when the plugin is installed
    -- or updated. When the plugin spec also has a `build` command, the plugin's `build.lua` not be
    -- executed. In this case, a warning message will be shown.
    warn_on_override = true,
  },
  -- Enable profiling of lazy.nvim. This will add some overhead,
  -- so only enable this when you are debugging lazy.nvim
  profiling = {
    -- Enables extra stats on the debug tab related to the loader cache.
    -- Additionally gathers stats about all package.loaders
    loader = false,
    -- Track each new require in the Lazy profiling tab
    require = false,
  },
}

-- builtin (core) plugins
local defaults = require "plugins"

--
function M.setup()
  log:TRACE "loading plugins"
  local lazy_available, lazy = pcall(require, "lazy")
  if not lazy_available then
    log:ERROR "skipping loading plugins until lazy.nvim is installed"
    return
  end

  -- remove plugins from rtp before loading lazy, so that all plugins won't be loaded on startup
  vim.opt.rtp:remove(utils.join_paths(_G.plugins_dir, "*"))

  table.insert(dvim.plugins, defaults)

  local status_ok = xpcall(function()
    table.insert(dvim.lazy.install.colorscheme, 1, dvim.colorscheme)
    lazy.setup(dvim.plugins, dvim.lazy)
  end, debug.traceback)

  if not status_ok then
    log:WARN "problems detected while loading plugins"
    log:TRACE(debug.traceback())
  end
end

return M
