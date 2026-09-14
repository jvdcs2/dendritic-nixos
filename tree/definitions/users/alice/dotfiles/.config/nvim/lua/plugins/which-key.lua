vim.pack.add({ "https://github.com/folke/which-key.nvim" })

require("which-key").setup({
	delay = 200, -- Delay (ms) before popup shows
	preset = "modern", -- "classic", "modern", or "helix"
	notify = false, -- Disable startup notifications
	win = {
		border = "rounded",
		no_overlap = false, -- Prevents the popup from shifting when cursor is at the bottom
	},
	icons = {
		separator = " ",
	},
})
