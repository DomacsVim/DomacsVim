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

-- import keymappings
local keymappings = require("keymappings.keymappings")

function M.init()
	for modes, _ in pairs(keymappings) do
    dvim.keys[modes] = {}
    for key, value in pairs(keymappings[modes]) do
    	if
    		type(key) and type(value) == "string"
    		or type(value) == "function" and value ~= false
    		or value ~= nil
    	then
        dvim.keys[modes][key] = value
      else
        print("Keybindings are not set.")
    	end
    end
	end
end

function M.load()
  local keys = dvim.keys
	for modes, _ in pairs(keys) do
    for key, value in pairs(keys[modes]) do
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
