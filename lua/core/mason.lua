local M = {}

local editor_layout = {
	height = vim.o.lines - vim.o.cmdheight + 1,
	width = vim.o.columns,
}

function M.config()
	dvim.core.mason = {
		ensure_installed = {
			"lua-language-server",
		},
		ui = {
			icons = {
				-- The list icon to use for installed packages.
				package_installed = dvim.icons.ui.check,
				-- The list icon to use for packages that are installing, or queued for installation.
				package_pending = dvim.icons.ui.pending,
				-- The list icon to use for packages that are not installed.
				package_uninstalled = dvim.icons.ui.fail,
			},
			border = "none",
			width = math.floor(editor_layout.width * 0.8),
			height = math.floor(editor_layout.height * 0.73),
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
		max_concurrent_installers = 10,
	}
end

function M.setup()
	require("mason").setup(dvim.core.mason)
end

return M
