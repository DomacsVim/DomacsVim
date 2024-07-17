local M = {}

local log = require "utils.log"

M.defaults = {
  active = true,
  keymappings = {},
  configs = {
    manual_mode = false,

    ---@usage Methods of detecting the root directory
    --- Allowed values: **"lsp"** uses the native neovim lsp
    --- **"pattern"** uses vim-rooter like glob pattern matching. Here
    --- order matters: if one is not detected, the other is used as fallback. You
    --- can also delete or rearangne the detection methods.
    -- detection_methods = { "lsp", "pattern" },
    -- NOTE: lsp detection will get annoying with multiple langs in one project
    detection_methods = { "pattern" },

    -- All the patterns used to detect root dir, when **"pattern"** is in
    -- detection_methods
    patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "pom.xml" },

    -- Table of lsp clients to ignore by name
    -- eg: { "efm", ... }
    ignore_lsp = {},

    -- Don't calculate root dir on specific directories
    -- Ex: { "~/.cargo/*", ... }
    exclude_dirs = {},

    -- Show hidden files in telescope
    show_hidden = false,

    -- When set to false, you will get a message when project.nvim changes your
    -- directory.
    silent_chdir = true,

    -- What scope to change the directory, valid options are
    -- * global (default)
    -- * tab
    -- * win
    scope_chdir = "global",

    ---@type string
    ---@usage path to store the project history for use in telescope
    datapath = _G.dvim_cache_dir,
  },
}

function M.setup()
  local status_ok, project = pcall(require, "project_nvim")
  if not status_ok then
    log:ERROR "Failed to load project_nvim module."
    return
  end

  project.setup(dvim.core.project.configs)
end

return M
