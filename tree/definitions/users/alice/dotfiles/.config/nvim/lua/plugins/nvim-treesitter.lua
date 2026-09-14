vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })
vim.pack.add({ "https://github.com/MeanderingProgrammer/treesitter-modules.nvim" })

local ts = require("nvim-treesitter")
ts.setup({
	-- install_dir = vim.fn.stdpath('data') .. '/site',
})
ts.install({ "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "toml" })

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
