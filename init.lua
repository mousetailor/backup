-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end


vim.opt.rtp:prepend(lazypath)
vim.g.python3_host_prog = "/usr/bin/python3" -- Adjust this if needed

-- Enable line numbers
vim.wo.number = true -- Show line numbers
vim.wo.relativenumber = true -- Show relative line numbers

vim.keymap.set("i", "<C-H>", "<C-W>", { noremap = true, silent = true }) -- In insert mode
vim.keymap.set("c", "<C-H>", "<C-W>", { noremap = true, silent = true }) -- In command-line mode

vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<Leader>l", ":Avante<CR>", { noremap = true, silent = true })
--vim.api.nvim_set_keymap('v', '<C-_>', '\"zy:s/^/\/\/ /g<CR>\"zp', { noremap = true }) -- Comment
--vim.api.nvim_set_keymap('v', '<C-\\>', '\"zy:s/^\/\/ //g<CR>\"zp', { noremap = true }) -- Uncomment

require("vim-options")

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ import = "plugins" }, -- Here it looks for the 'plugins' directory
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true },
	opts = {
		rocks = {
			hererocks = false, -- disable Hererocks
			enabled = false, -- disable LuaRocks support
		},
	},
})
