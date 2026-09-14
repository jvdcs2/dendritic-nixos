vim.pack.add({
	"https://github.com/kevinhwang91/promise-async",
	"https://github.com/kevinhwang91/nvim-ufo",
})

require("ufo").setup({
	-- Tells UFO to look for Treesitter first, and fallback to indentation folding
	provider_selector = function(bufnr, filetype, buftype)
		return { "treesitter", "indent" }
	end,
	open_fold_hl_timeout = 0,
})

-- Clean up the fold UI characters (requires a Nerd Font for the arrows)
-- vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

vim.o.foldcolumn = "0" -- '1' shows a dedicated fold gutter, '0' hides it
vim.o.foldlevel = 99 -- High value ensures folds are not closed automatically
vim.o.foldlevelstart = 99 -- Start with all folds completely open
vim.o.foldenable = true -- Enable folding
