vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/rachartier/tiny-devicons-auto-colors.nvim",
})

local devicons_ok, devicons = pcall(require, "nvim-web-devicons")
local tiny_ok, tiny_devicons = pcall(require, "tiny-devicons-auto-colors")

local p = require("palette")
if devicons_ok and tiny_ok then
	devicons.setup()
	tiny_devicons.setup({
		colors = { p.blue, p.cyan, p.green, p.yellow, p.red, p.magenta },
		cache = { enabled = true },
	})
end
