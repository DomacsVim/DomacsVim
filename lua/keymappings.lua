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

M.defaults = {
  insert_mode = {
    ["<A-j>"] = "<Esc>:m .+1<CR>==gi",
    ["<A-k>"] = "<Esc>:m .-2<CR>==gi",
    ["<C-h>"] = "<Left>",
    ["<C-l>"] = "<Right>",
    ["<C-j>"] = "<Down>",
    ["<C-k>"] = "<Up>",
  },
  normal_mode = {
    ["<ESC>"] = ":nohlsearch <CR>",
    ["<C-n>"] = ":enew <CR>",
    ["<C-u>"] = ": undo <cr>",
    ["<C-r>"] = ": redo <cr>",
    ["<C-a>"] = "ggVG",
    ["<C-y>"] = "yy",
    ["<C-x>"] = "dd",
    ["<C-h>"] = "<C-w>h",
    ["<C-j>"] = "<C-w>j",
    ["<C-k>"] = "<C-w>k",
    ["<C-l>"] = "<C-w>l",
    ["<C-Up>"] = ":resize -2<CR>",
    ["<C-Down>"] = ":resize +2<CR>",
    ["<C-Left>"] = ":vertical resize -2<CR>",
    ["<C-Right>"] = ":vertical resize +2<CR>",
    ["<A-k>"] = ":resize -2<CR>",
    ["<A-j>"] = ":resize +2<CR>",
    ["<A-h>"] = ":vertical resize -2<CR>",
    ["<A-l>"] = ":vertical resize +2<CR>",
    ["<C-w>"] = ":lua require('core.bufferline').buf_kill()<CR>",
    ["f"] = "za",
    ["H"] = "I<esc>",
    ["E"] = "<end>",
    [">"] = ">>",
    ["<"] = "<<",
  },
  visual_mode = {
    [">"] = ">gv",
    ["<"] = "<gv",
    ["H"] = "<home>",
    ["E"] = "<end>",
    ["<C-y>"] = "y",
    ["<A-j>"] = ":m '>+1<CR>gv-gv",
    ["<A-k>"] = ":m '<-2<CR>gv-gv",
  },
  command_mode = {},
  term_mode = {},
}

function M.load(keymap)
  for modes, _ in pairs(keymap) do
    for key, value in pairs(keymap[modes]) do
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

return M
