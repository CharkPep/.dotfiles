-- Autosave on leave from insert to normal, or changes in normal mode
vim.api.nvim_create_autocmd({ "InsertLeave", "CursorHoldI" }, {
	desc = "Autosave on leave",
	pattern = "*",
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		if not vim.bo[buf].readonly and (vim.bo[buf].buftype == "acwrite" or vim.bo[buf].buftype == "") then
			vim.api.nvim_win_call(0, function()
				vim.api.nvim_command("silent write")
			end)
		end
	end,
})

return {}
