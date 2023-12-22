local M = {}

local log = require("utils.log")

vim.g.mapleader = dvim.keys.leadermap

local options = { noremap = true, silent = true }

-- defined modes
local modes = {
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

dvim.keys = vim.tbl_deep_extend("force", defaults, dvim.keys)

-- @param mode, key, value type checking returns true output if confirmed else return false
local function check_input_type(mode, key, value)
	local result
	if type(mode) == "string" and type(key) == "string" and type(value) == "string" or type(value) == "function" then
		if mode ~= "" and key ~= "" and value ~= "" then
			result = true
			log:TRACE("The structure of the keys is correct.")
		end
	elseif value == false or value == {} or value == nil then
		result = false
		log:TRACE("The structure of the keys is incorrect.")
	end
	return result
end

local function set_keymappings(mode, key, value)
	if check_input_type(mode, key, value) == true then
		vim.keymap.set(mode, key, value, options)
	end
end

local function remove_disabled_keys(mode, key)
	if check_input_type(mode, key) then
		vim.keymap.del(mode, key)
	end
end

function M.load_keymappings()
	for items, values in pairs(dvim.keys) do
		if type(values) == "table" then
			for key, value in pairs(values) do
				set_keymappings(modes[items], key, value)
				remove_disabled_keys(modes[items], key)
			end
		end
	end
end

return M
