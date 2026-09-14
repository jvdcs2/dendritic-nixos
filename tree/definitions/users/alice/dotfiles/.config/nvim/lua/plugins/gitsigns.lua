vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

require("gitsigns").setup({
	-- signcolumn = true,          -- Ensure the gutter is open
	-- attach_to_untracked = true, -- Enable tracking for new files
	signs = {
		untracked = { text = "┃" },
	},
	update_debounce = 1, -- Debounce time in milliseconds
})
