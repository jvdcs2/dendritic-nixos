vim.pack.add({ "https://github.com/stevearc/conform.nvim" })

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		nix = { "alejandra" },
		typst = { "typstar" },
		-- python = { 'isort', 'black' },
		-- javascript = { 'prettier' },
		-- typescript = { 'prettier' },
		-- '_' = { 'trim_whitespace' },
	},
	format_on_save = {
		timeout_ms = 1000,
		lsp_format = "fallback", -- Use LSP formatting if no dedicated formatter exists
	},
})
