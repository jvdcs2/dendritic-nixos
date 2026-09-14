vim.pack.add({
	"https://github.com/jghauser/fold-cycle.nvim",
})

require("fold-cycle").setup({
	open_if_max_closed = false, -- closing a fully closed fold will open it[reference:0]
	close_if_max_opened = false, -- opening a fully open fold will close it[reference:1]
})
