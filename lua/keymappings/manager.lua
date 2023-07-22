local M = {}

vim.g.mapleader = dvim.mapleader

local options = { noremap = true, silent = true }

local mode_adapters = {
	insert_mode = "i",
	normal_mode = "n",
	term_mode = "t",
	visual_mode = "v",
	command_mode = "c",
}

function M.load()
	local keymappings = require("keymappings.keymappings").defaults
	dvim.keys = vim.tbl_extend("keep", keymappings, dvim.keys)

	for group, _ in pairs(dvim.keys) do
		for modes, _ in pairs(dvim.keys[group]) do
			for key, value in pairs(dvim.keys[group][modes]) do
				if
					type(key) == "string" and type(value) == "string"
					or type(value) == "function" and not value == false
					or not value == nil
				then
					-- set keymappings
					vim.keymap.set(mode_adapters[modes], key, value, options)
				else
					-- remove disable keys
					pcall(vim.api.nvim_del_keymap, mode_adapters[modes], key)
				end
			end
		end
	end
end

return M
