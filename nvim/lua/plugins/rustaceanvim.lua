local rustaceanvim = {
	"mrcjkb/rustaceanvim",
	version = "5^",
	lazy = false, -- This plugin is already lazy
	init = function()
		-- Load configuration beforce calling init
		require("config.rustacceanvim")
	end,
	config = function() end,
}

return rustaceanvim
