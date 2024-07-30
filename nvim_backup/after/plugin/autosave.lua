vim.api.nvim_create_user_command("BufVars", function ()
	local buf = vim.api.nvim_get_current_buf()
	local vars = vim.fn.getbufvar(buf, "&")
	for k, v in pairs(vars) do
		print(k, v)
	end
end, {})

-- Autosave on leave from insert to normal, or changes in normal mode
vim.api.nvim_create_autocmd({ "InsertLeave", "CursorHoldI" }, {
	desc = "Autosave on leave",
	pattern="*",
	callback = function()
		local notallowed = { TelescopePrompt = true }
		local buf = vim.api.nvim_get_current_buf()
		local buftype = vim.fn.getbufvar(buf, "&modifiable")
		local modified = vim.fn.getbufvar(buf, "&modified")
		local filetype = vim.fn.getbufvar(buf, "&filetype")
		if buftype == 1 and modified == 1 and not notallowed[filetype] then
			vim.notify("Saved")
			vim.api.nvim_win_call(0, function ()
				vim.api.nvim_command("write")
			end)
		end
	end,
})

return {}
