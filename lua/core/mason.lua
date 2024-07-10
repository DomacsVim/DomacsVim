local M = {}

local utils = require("utils.modules")

M.defaults = {
  configs = {
    ui = {
      icons = {
        -- The list icon to use for installed packages.
        package_installed = dvim.icons.ui.check,
        -- The list icon to use for packages that are installing, or queued for installation.
        package_pending = dvim.icons.ui.pending,
        -- The list icon to use for packages that are not installed.
        package_uninstalled = dvim.icons.ui.fail,
      },
      border = "rounded",
      width = 0.7,
      height = 0.7,
      keymaps = {
        -- Keymap to expand a package
        toggle_package_expand = "<CR>",
        -- Keymap to install the package under the current cursor position
        install_package = "i",
        -- Keymap to reinstall/update the package under the current cursor position
        update_package = "u",
        -- Keymap to check for new version for the package under the current cursor position
        check_package_version = "c",
        -- Keymap to update all installed packages
        update_all_packages = "U",
        -- Keymap to check which installed packages are outdated
        check_outdated_packages = "C",
        -- Keymap to uninstall a package
        uninstall_package = "X",
        -- Keymap to cancel a package installation
        cancel_installation = "<C-c>",
        -- Keymap to apply language filter
        apply_language_filter = "<C-f>",
      },
    },
    PATH = "skip",
    install_root_dir = utils.join_paths(vim.fn.stdpath("data"), "mason"),
    max_concurrent_installers = 5,
    registries = {
      "lua:mason-registry.index",
      "github:mason-org/mason-registry",
    },
    providers = {
      "mason.providers.registry-api",
      "mason.providers.client",
    },
  },
}

function M.setup()
  local status_ok, mason = pcall(require, "mason")
  if not status_ok then
    return
  end

  dvim.core.mason.configs.PATH = "append"

  mason.setup(dvim.core.mason.configs)
end

return M
