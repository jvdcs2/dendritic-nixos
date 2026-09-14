-- ~/.config/nvim/init.lua (or wherever you keep your plugins)

vim.pack.add({ "https://github.com/lewis6991/hover.nvim" })

require("hover").config({
	providers = { "hover.providers.lsp" }, -- LSP only. That's it.
	preview_opts = { border = "rounded" }, -- Options: "single", "double", "rounded", "shadow"
	title = true, -- Shows "LSP" in the window header
	preview_window = false, -- Don't send to split on second press
})

-- Your K key. Nothing else.
vim.keymap.set("n", "K", function()
	require("hover").open()
end, { desc = "hover.nvim (LSP)" })
