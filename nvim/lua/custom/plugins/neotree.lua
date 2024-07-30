local is_tree_open = false
local neotree = {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
}

vim.keymap.set("n", "<C-e>", function()
	if is_tree_open then
		is_tree_open = false
		require("neo-tree.command").execute({
			action = "close",
		})
		return
	end

	local full_path = vim.fn.expand("%:p")
	print(full_path)
	if full_path == "" then
		full_path = vim.fn.getcwd()
	else
		local f = io.open(full_path, "r")
		if f then
			f.close(f)
		else
			full_path = vim.fn.getcwd()
		end
	end
	is_tree_open = true
	require("neo-tree.command").execute({
		action = "focus", -- OPTIONAL, this is the default value
		source = "filesystem", -- OPTIONAL, this is the default value
		position = "right", -- OPTIONAL, this is the default value
		reveal_file = full_path, -- path to file or folder to reveal
		reveal_force_cwd = true, -- change cwd without asking if needed
	})
end, { desc = "Open neo-tree at current file or working directory", noremap = true })

-- vim.neo_tree.is_tree_open = function()
-- 	return is_tree_open
-- end

return neotree
