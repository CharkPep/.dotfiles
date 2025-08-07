require("vim.lsp")

--- @type vim.lsp.ClientConfig
local config = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			completion = {
				callSnippet = "Replace",
			},
			diagnostics = {
				globals = { "vim" },
				disable = { "missing-fields" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
					[require("lazy.core.config").options.root .. "/"] = true,
				},
			},
			format = {
				enable = true,
				-- Put format options here
				-- NOTE: the value should be STRING!!
				defaultConfig = {
					indent_style = "tab",
					indent_size = "4",
				},
			},
		},
	},
}

return config
