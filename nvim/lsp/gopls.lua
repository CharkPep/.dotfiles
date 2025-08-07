require("vim.lsp")

--- @type vim.lsp.ClientConfig
local config = {
	cmd = { "gopls" },
	root_markers = { "go.work", "go.mod" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	settings = {
		completeUnimported = true,
		usePlaceholders = true,
		analyses = {
			unusedparams = true,
		},
	},
}

return config
