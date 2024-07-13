# [DomacsVim](https://domacsvim.vercel.app) - A free, open source and intelligent IDE for NeoVim.

An IDE layer for Neovim with beautiful, flexible, extensible and completely free and open source lua-based configurations for Unix-based systems.

[Get Started](https://domacsvim.vercel.app/documentation/getting-started#getting-started) -
[Try with Docker](https://domacsvim.vercel.app/documentation/getting-started#try-it-with-docker)

## Collaboration

If you are interested in fixing issues and contributing directly to the code base, please see the document [CONTRIBUTING.md](https://gitlab.com/domacsvim/domacsvim/-/blob/main/CONTRIBUTING.md)

## Configuration

config file named ‍‍‍`init.lua` on the `~/.config/dvim` path is that with the first implementation, `dvim` it's gonna be built. You can see a simple example of personalization below.

```lua
---- Note: After applying changes restart dvim ----

--- To change colorscheme :
-- dvim.colorscheme

--- To change leader key :
-- dvim.keys.leadermap = " "

--- To install plugins :
-- dvim.plugins = {}

--- Change options
-- vim.opt.ruler = false

--- Set Keymappings
-- modes: normal_mode, insert_mode, visual_mode, term_mode
-- dvim.keys.normal_mode["key"] = "value" or function() end

--- Change icons
--            devicons
--            kind_icons
-- dvim.icons.ui.info = "..."

--- LSP configs
-- dvim.lsp.linting.linters_by_ft = {} or etc ... you can see lspconfigs in lua/lsp/configs.lua

--- Change core configs
-- dvim.core.nvimtree = {
--   active = true,
--   keymappings = {},
--   configs = {
--     view = {
--       width = 50
--     }
--   }
-- }
```
