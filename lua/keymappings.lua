local M = {}

local log = require("utils.log")

vim.g.mapleader = dvim.keys.leadermap

local options = { noremap = true, silent = true }

local mode_adapters = {
	term_mode = "t",
	insert_mode = "i",
	normal_mode = "n",
	visual_mode = "v",
	command_mode = "c",
}

-- default keybindings
local defaults = {
	term_mode = {},
	insert_mode = {},
	normal_mode = {},
	visual_mode = {},
	command_mode = {},
}

function M.init()
	for modes, _ in pairs(defaults) do
		for key, value in pairs(defaults[modes]) do
			if
				type(key) and type(value) == "string"
				or type(value) == "function" and value ~= false
				or value ~= nil
			then
				dvim.keys[modes][key] = value
				local message = "Keybindings are set."
				log:TRACE(message)
			else
				local message = "Keybindings are not set."
				log:WARN(message)
			end
		end
	end
end

function M.load_mappings()
	for modes, _ in pairs(defaults) do
		for key, value in pairs(dvim.keys[modes]) do
			if
				type(key) and type(value) == "string"
				or type(value) == "function" and value ~= false
				or value ~= nil
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

return M
