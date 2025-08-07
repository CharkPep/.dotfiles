require("rustaceanvim")
require("io")

---@type rustaceanvim.Opts
vim.g.rustaceanvim = {
	tools = {
		enable_clippy = true,
	},
	server = {
		auto_attach = true,
		on_attach = function(_, bufnr)
			vim.keymap.set("n", "E", function()
				vim.cmd.RustLsp("expandMacro")
			end, {
				buffer = bufnr,
				desc = "Expand Macro under the cursor",
				noremap = true,
			})

			-- TODO: Refactor this to check if group exists without recreating
			-- vim.api.nvim_del_augroup_by_name("float_diagnostic")
			-- vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			-- 	group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
			-- 	callback = function()
			-- 		vim.cmd.RustLsp({ "renderDiagnostic", "current" })
			-- 	end,
			-- })

			-- vim.keymap.set("n", "<leader>a", function()
			-- 	vim.cmd.RustLsp("codeAction")
			-- end, { buffer = bufnr, desc = "Rustacean Code [A]ction", noremap = true })

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

			-- Wrapper for LSP request cancelation https://github.com/neovim/neovim/issues/30985
			for _, method in ipairs({ "textDocument/diagnostic", "workspace/diagnostic" }) do
				local default_diagnostic_handler = vim.lsp.handlers[method]
				vim.lsp.handlers[method] = function(err, result, context, config)
					if err ~= nil and err.code ~= nil and err.code == -32802 then
						return
					end
					return default_diagnostic_handler(err, result, context, config)
				end
			end
		end,
		-- Rust analyzer depending on the project (ussually a huge workspace) requires extensive configuration
		-- that can no be generalized. For that purpose `.rust-analyzer.json` at the root of the workspace (project)
		-- is used to merge default_settings with `.rust-analyzer.json` settings.
		settings = function(workspace_root, default_settings)
			local path = workspace_root .. "/.rust-analyzer.json"
			path = vim.fn.resolve(path)
			local f = io.open(path, "r")
			if f then
				local settings = f:read("a")
				settings = vim.json.decode(settings)
				if not settings then
					vim.notify("Failed to parse settings.json config", vim.log.levels.ERROR)
				end

				vim.tbl_deep_extend("force", default_settings, settings)
				io.close(f)
			end

			return default_settings
		end,
		default_settings = {
			["rust-analyzer"] = {},
		},
	},

	dap = nil,
}
