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
