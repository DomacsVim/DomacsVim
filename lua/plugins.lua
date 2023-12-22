return {
	{
		"https://gitlab.com/domacsvim/themer",
		config = function()
			local themer = require("themer")
			themer.apply_theme()
		end,
		lazy = false
	}
}
