local rustaceanvim = {
	"mrcjkb/rustaceanvim",
	version = "5^",
	lazy = false, -- This plugin is already lazy
	init = function()
		require("config.rustacceanvim")
	end,
	config = function() end,
}

return rustaceanvim
