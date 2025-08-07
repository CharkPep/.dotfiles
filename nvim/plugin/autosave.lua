-- There are generally three cases when one want to flush the buffer:
-- 1) Exiting neovim.
-- 2) Existing from the <Insert> mode.
-- 3) In normal mode after pasting or deleting buffer content (BufModifiedSet cover more cases, but the only one that can be used for that perpose).
vim.api.nvim_create_autocmd({ "VimLeave", "InsertLeave", "BufModifiedSet" }, {
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
