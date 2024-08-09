---@type RustaceanOpts
vim.g.rustaceanvim = {
	---@type RustaceanToolsOpts
	tools = {
		enable_clippy = true,
	},
	--- @type RustaceanLspClientOpts
	server = {
		auto_attach = true,
		on_attach = function(client, bufnr)
			vim.keymap.set("n", "E", function()
				vim.cmd.RustLsp("expandMacro")
			end, {
				buffer = bufnr,
				desc = "Expand Macro under the cursor",
				noremap = true,
			})

			vim.api.nvim_del_augroup_by_name("float_diagnostic")
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
				callback = function()
					vim.cmd.RustLsp({ "renderDiagnostic", "current" })
				end,
			})

			vim.keymap.set("n", "<leader>a", function()
				vim.cmd.RustLsp("codeAction")
			end, { buffer = bufnr, desc = "Rustacean Code [A]ction", noremap = true })

			vim.keymap.set("n", "<leader>d", function()
				vim.cmd.RustLsp("openDocs")
			end, { buffer = bufnr, desc = "Go Rust [D]ocs", noremap = true })

			vim.api.nvim_create_autocmd({ "InsertLeave" }, {
				buffer = bufnr,
				desc = "Run flycheck",
				callback = function()
					vim.cmd.RustLsp({ "flyCheck", "run" })
				end,
			})
		end,
		default_settings = {
			["rust-analyzer"] = {},
		},
	},
	---@type RustaceanDapOpts
	dap = nil,
}
