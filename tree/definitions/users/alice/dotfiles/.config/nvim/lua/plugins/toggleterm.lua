vim.pack.add({ "https://github.com/akinsho/toggleterm.nvim" })

require("toggleterm").setup({
	open_mapping = [[<C-\>]], -- Toggle floating terminal with Ctrl + \
	direction = "float", -- Options: 'float' | 'horizontal' | 'vertical' | 'tab'

	-- DEFAULTS FOR YOU TO EDIT:
	size = 20, -- Size for split directions
	start_in_insert = true, -- Focus insert mode immediately on open
	persist_size = true, -- Retain terminal size across toggles
	close_on_exit = true, -- Close window when subshell process exits
	float_opts = { border = "curved" }, -- Options: 'single' | 'double' | 'shadow' | 'curved'
})

vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.statuscolumn = "" -- override any custom statuscolumn for this buffer
		vim.opt_local.signcolumn = "no" -- optional, kills the empty gutter too
	end,
})
