-- get and set the domacsvim runtimepath
_G.dvim_runtime_dir = vim.env.DVIM_RUNTIME_DIR or debug.getinfo(1, "S").source:sub(2):match("(.*[/\\])"):sub(1, -2)
vim.opt.rtp:prepend(dvim_runtime_dir)
