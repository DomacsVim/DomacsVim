local M = {}

M.defaults = {
  common = {
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
  },
  nvimtree = {
    normal_mode = {
      ["<C-e>"] = ":NvimTreeToggle<CR>"
    }
  },
  gitsigns = {
    normal_mode = {
      ["gr"] = ":Gitsigns reset_hunk<CR>",
      ["gn"] = ":Gitsigns next_hunk<CR>",
      ["gp"] = ":Gitsigns prev_hunk<CR>",
      ["gk"] = ":Gitsigns preview_hunk<CR>",
      ["gi"] = ":Gitsigns preview_hunk_inline<CR>"
    }
  },
  comments = {
    normal_mode = {
      ["<C-_>"] = "<Plug>(comment_toggle_linewise_current)"
    },
    visual_mode = {
      ["<C-_>"] = "<Plug>(comment_toggle_linewise_visual)"
    }
  },
  terminal = {
    normal_mode = {
      ["t"] = ":ToggleTerm<CR>"
    },
    term_mode = {
      ["<esc>"] = "<C-\\><C-n>",
      ["<C-h>"] = "<C-\\><C-N><C-w>h",
      ["<C-j>"] = "<C-\\><C-N><C-w>j",
      ["<C-k>"] = "<C-\\><C-N><C-w>k",
      ["<C-l>"] = "<C-\\><C-N><C-w>l"
    }
  },
  bufferline = {
    normal_mode = {
      ["<Tab>"] = ":bnext<CR>",
      ["<S-Tab>"] = ":bprevious<CR>"
    }
  }
}

return M
