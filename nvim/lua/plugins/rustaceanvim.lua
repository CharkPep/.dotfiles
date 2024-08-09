local rustaceanvim = {}
require("config.rustacceanvim")
rustaceanvim ={
	'mrcjkb/rustaceanvim',
	version = '^4', -- Recommended
	lazy = false, -- This plugin is already lazy
	config = function () end,
}

-- TODO hook to save event
return rustaceanvim
