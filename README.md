# [DomacsVim](https://domacsvim.vercel.app) - A free, open source and intelligent IDE for NeoVim.

An IDE layer for Neovim with beautiful, flexible, extensible and completely free and open source lua-based configurations for Unix-based systems.

[Get Started](https://domacsvim.vercel.app/documentation/getting-started#getting-started) -
[Try with Docker](https://domacsvim.vercel.app/documentation/getting-started#try-it-with-docker)

## Collaboration

If you are interested in fixing issues and contributing directly to the code base, please see the document [CONTRIBUTING.md](https://gitlab.com/domacsvim/domacsvim/-/blob/main/CONTRIBUTING.md)

## Configuration

As mentioned, The path where user customization files are placed is ‍‍`~/.config/dvim` which is created by default at runtime. You can see a simple example of personalization below.

```lua
-- add custom keys
dvim.keys = {}
-- template :
--   dvim.keys[mode][key] = value
--   modes:
--     you can see modes with :dvim.key<tab>
-- add custom plugins
dvim.plugins = {}
-- set leaderkey
dvim.mapleader = " "
-- set theme
dvim.colorscheme = "onedark"
-- change configs
-- you can see the modules in here :
--   for module, _ in pairs(dvim.core) do
--     print(module)
--   end
-- template :
-- dvim.core.[module].[pattern].[...]
-- example :
dvim.core.nvimtree.view.width = 31
-- change default icons
-- dvim.icons.[category].[icon]
-- categorys :
--    devicons, ui, kind_icons
-- dvim.icons.ui.search = " "
-- dvim.icons.devicons["html"] = " "
-- dvim.icons.kind_icons.folder = " "
dvim.icons.kind_icons.folder = " "
-- change options
-- you can see the options in here :
--   vim.opt.backup = false, -- creates a backup file
--   vim.opt.clipboard = "unnamedplus", -- allows neovim to access the system clipboard
--   vim.opt.cmdheight = 1, -- more space in the neovim command line for displaying messages
--   vim.opt.completeopt = "menu,menuone,noselect",
--   vim.opt.conceallevel = 0, -- so that `` is visible in markdown files
--   vim.opt.fileencoding = "utf-8", -- the encoding written to a file
--   vim.opt.foldmethod = "manual", -- folding, set to "expr" for treesitter based folding
--   vim.opt.foldexpr = "", -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
--   vim.opt.guifont = "monospace:h17", -- the font used in graphical neovim applications
--   vim.opt.hidden = true, -- required to keep multiple buffers and open multiple buffers
--   vim.opt.hlsearch = true, -- highlight all matches on previous search pattern
--   vim.opt.ignorecase = true, -- ignore case in search patterns
--   vim.opt.mouse = "a", -- allow the mouse to be used in neovim
--   vim.opt.pumheight = 10, -- pop up menu height
--   vim.opt.showmode = false, -- we don't need to see things like -- INSERT -- anymore
--   vim.opt.smartcase = true, -- smart case
--   vim.opt.splitbelow = true, -- force all horizontal splits to go below current window
--   vim.opt.splitright = true, -- force all vertical splits to go to the right of current window
--   vim.opt.swapfile = false, -- creates a swapfile
--   vim.opt.termguicolors = true, -- set term gui colors (most terminals support this)
--   vim.opt.timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
--   vim.opt.title = true, -- set the title of window to the value of the titlestring
--   vim.opt.titlestring = "%<%F - DomacsVim", -- what the title of the window will be set to
--   vim.opt.undodir = undodir, -- set an undo directory
--   vim.opt.undofile = true, -- enable persistent undo
--   vim.opt.updatetime = 100, -- faster completion
--   vim.opt.writebackup = false, -- if a file is being edited by another program
--   vim.opt.expandtab = true, -- convert tabs to spaces
--   vim.opt.shiftwidth = 2, -- the number of spaces inserted for each indentation
--   vim.opt.tabstop = 2, -- insert 2 spaces for a tab
--   vim.opt.cursorline = true, -- highlight the current line
--   vim.opt.number = true, -- set numbered lines
--   vim.opt.numberwidth = 4, -- set number column width to 2 {default 4}
--   vim.opt.signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
--   vim.opt.wrap = false, -- display lines as one long line
--   vim.opt.shadafile = dvim_cache_dir .. "/dvim.shada",
--   vim.opt.scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor.
--   vim.opt.sidescrolloff = 8, -- minimal number of screen lines to keep left and right of the cursor.
--   vim.opt.showcmd = false,
--   vim.opt.ruler = false,
--   vim.opt.laststatus = 3,
-- Lspconfig:
-- vim.lsp.set_log_level("debug")
-- dvim.core.lspconfig.[pattern]

-- you can add you own structure :
-- for example, add lua/ directory and and write plugins.lua in here or add lua/configs or lua/keymappings or ...
```
