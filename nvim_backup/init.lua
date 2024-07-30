--
--
--
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = false

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
-- vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!

vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- -- sync clipboard between os and neovim.
-- --  remove this option if you want your os clipboard to remain independent.
-- --  see `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"


-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- TODO hook to save event
---@type RustaceanOpts
vim.g.rustaceanvim = {
	---@type RustaceanToolsOpts
	tools = {
		enable_clippy = true
	},
	---@type RustaceanLspClientOpts
	server = {
		auto_attach=true,
		on_attach = function(client, bufnr)
			-- Set keybindings, etc. here.
			vim.api.nvim_create_autocmd({ "InsertLeave" }, {
				buffer=bufnr,
				desc="Run flycheck",
				callback = function ()
					vim.cmd.RustLsp { 'flyCheck', 'run' }
				end
			})
		end,
		default_settings = {
			['rust-analyzer'] = {
			},
		},
	},
	---@type RustaceanDapOpts
	dap = {},
 }
-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Fast horizontal movement with ctrl-d/u by @Primeagen, moves half a window down/up
vim.keymap.set({ "n", "v" }, "<A-j>", "<C-d>zz", { desc = "[J]ump half viewpoint down" })
vim.keymap.set({ "n", "v" }, "<A-k>", "<C-u>zz", { desc = "[K]ick(jump) half viewpoint up" })

-- Exit to fs
-- vim.keymap.set("n", "<leader>p", "<cmd>Ex<CR>")

-- Comment

-- vim.keymap.set("n", "<C-_>", function()
-- require("Comment.api").toggle.linewise.current()
-- end, { noremap = true, silent = true })

-- local esc = vim.api.nvim_replace_termcodes("<ESC>"c> true, false, true)
--
-- -- Toggle selection (linewise)
-- vim.keymap.set("x", "<leader>c", function()
-- vim.api.nvim_feedkeys(esc, "nx", false)
-- require("comment.api").toggle.linewise(vim.fn.visualmode())
-- end)

-- TODO: Move tabs with Tab, Shift-Tab

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- require("lazy").load({
-- 	change_detection = {
-- 		notify = false,
-- 	},
-- })

-- One line plugins without configuration
require("lazy").setup({
    change_detection = {
      notify = false,
    },
    -- "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
    {
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
    },
    {
      import = "custom.plugins"
    },
  },
  {
    change_detection = {
      notify = false,
    },
    -- as defined per Nerd Font
    ui = {},
  })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
