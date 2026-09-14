vim.pack.add({ "https://github.com/sindrets/winshift.nvim" })

require("winshift").setup({
	opts = {
		highlight_moving_win = true,
		focused_hl_group = "Visual",
	},
})
