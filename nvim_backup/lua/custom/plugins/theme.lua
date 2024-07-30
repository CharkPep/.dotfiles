local themes= {
	"Catppuccin-latte",
	"Catppuccin-frappe",
	"Catppuccin-macchiato",
	"Catppuccin-mocha"
}

local bufh
local winId
local function onSelect(line)
	vim.g:set_flavor(string.sub(themes[line], 12))
	local plugin = require("lazy.core.config").plugins["catppuccin"]
	require("lazy.core.loader").reload(plugin)
end

local function set_keymaps()
	vim.api.nvim_buf_set_keymap(bufh, "n", "<CR>", "", {
		desc="Select item",
		callback=function ()
			local line = vim.api.nvim_win_get_cursor(winId)[1]
			onSelect(line)
			vim.api.nvim_win_close(winId, true)
		end
	})

	vim.api.nvim_buf_set_keymap(bufh, "n", "q", "", {
		desc="[Q]uit",
		callback=function ()
			vim.api.nvim_win_close(winId, true)
		end
	})
end

vim.keymap.set("n", "T", function ()
	local current_width = vim.api.nvim_win_get_width(0)
	local current_height = vim.api.nvim_win_get_height(0)

	local float_width = math.floor(current_width * 0.8)
	local float_height = math.floor(current_height * 0.8)

	local col = math.floor((current_width - float_width) / 2)
	local row = math.floor((current_height - float_height) / 2)
	bufh = vim.api.nvim_create_buf(false, true)
	set_keymaps()
	vim.api.nvim_buf_set_lines(bufh, 0, 1, false, themes)
	vim.api.nvim_buf_set_var(bufh, 'modifiable', false)
	vim.api.nvim_buf_set_var(bufh, 'bufhidden', 'wipe')
	vim.api.nvim_buf_set_var(bufh, 'filetype', 'selectlist')
	winId = vim.api.nvim_open_win(bufh, true, {
		relative = 'win',
		width = float_width,
		height = float_height,
		col = col,
		row = row,
		style = 'minimal',
		border = 'single'
	})
end, { noremap=true})


return {}


