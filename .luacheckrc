---@diagnostic disable
-- vim: ft=lua tw=80

stds.nvim = {
  globals = {
    "dvim",
    vim = { fields = { "g" } },
    "TERMINAL",
    "USER",
    "C",
    "Config",
    "WORKSPACE_PATH",
    "JAVA_LS_EXECUTABLE",
    "MUtils",
    "USER_CONFIG_PATH",
    os = { fields = { "capture" } },
  },
  read_globals = {
    "jit",
    "os",
    "vim",
    "dvim_runtime_dir",
    "dvim_config_dir",
    "dvim_cache_dir",
  },
}
std = "lua51+nvim"

-- Don't report unused self arguments of methods.
self = false

-- Rerun tests only if their modification time changed.
cache = true

exclude_files = {
  "database/*"
}
