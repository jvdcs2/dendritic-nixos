vim.pack.add({ "https://github.com/chomosuke/typst-preview.nvim" })

require("typst-preview").setup({
	-- debug = false,          -- Enable debug logging to data/typst-preview/log.txt
	-- open_cmd = nil,         -- Custom command to open preview, e.g. "firefox %s -P typst-preview"
	-- port = 0,               -- Custom port (0 = random)
	-- host = nil,             -- Custom host (0.0.0.0 not supported)
	open_cmd = "zen %s",
	follow_cursor = false,
})
