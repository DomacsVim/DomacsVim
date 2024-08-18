local M = {}

local log = require("utils.log")

-- set mapleader key
vim.g.mapleader = dvim.keys.leadermap

-- set options
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
  insert_mode = {
    ["<C-S-h>"] = "<Home>",
    ["<C-S-e>"] = "<End>",
    ["<C-h>"] = "<Left>",
    ["<C-l>"] = "<Right>",
    ["<C-j>"] = "<Down>",
    ["<C-k>"] = "<Up>",
  },
  normal_mode = {
    ["<S-h>"] = "<Home>",
    ["<S-e>"] = "<End>",
    ["<Tab>"] = ">>",
    ["<S-Tab>"] = "<<",
    ["<C-h>"] = "<C-w>h",
    ["<C-l>"] = "<C-w>l",
    ["<C-j>"] = "<C-w>j",
    ["<C-k>"] = "<C-w>k",
    ["<Esc>"] = "<cmd>noh<CR>",
  },
  visual_mode = {
    ["<Tab>"] = ">",
    ["<S-Tab>"] = "<",
  },
  command_mode = {},
}

-- global key to call keys
dvim.keys = vim.tbl_deep_extend("force", defaults, dvim.keys)

local function check_input_type(mode, key, value)
  local result
  if type(mode) == "string" and type(key) == "string" and type(value) == "string" or type(value) == "function" then
    if mode ~= "" and key ~= "" and value ~= "" then
      result = true
      log:TRACE("The structure of the keys is correct.")
    end
  elseif value == false or value == {} or value == nil then
    log:TRACE(value)
    result = false
  end
  return result
end

local function set_keymappings(mode, key, value)
  if check_input_type(mode, key, value) then
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
