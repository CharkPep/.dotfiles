local flavor = "mocha"
function vim.g:set_flavor(new_flavor)
	flavor=new_flavor
end

local catppuccin = {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	init = function()
		require("catppuccin").setup({
			flavour = flavor,
			default_integrations = true,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
return catppuccin
