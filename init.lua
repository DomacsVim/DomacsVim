-- get and set the domacsvim runtimepath
_G.dvim_runtime_dir = vim.env.DVIM_RUNTIME_DIR or debug.getinfo(1, "S").source:sub(2):match("(.*[/\\])"):sub(1, -2)
vim.opt.rtp:append(dvim_runtime_dir)
-- import bootstrap to setup runtimepath and etc ...
require("bootstrap").init()
-- import plugins with load method to load dvim.plugins
require("plugins.manager").load()
-- import keymappings
require("keymappings.manager").load()
