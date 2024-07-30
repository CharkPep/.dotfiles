local comment = {
	"numToStr/Comment.nvim",
	config = function()
	local config = {
	  toggler = {
	    line = "<C-_>",
	  },
	  opleader = {
	    line = "<C-_>",
	  },
	}

	require("Comment").setup(config)
	end,
}

return comment

