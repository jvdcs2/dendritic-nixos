-- NixOS: /etc/profiles/per-user/<user>/bin isn't always on $PATH for
-- non-login-shell launches (WM keybinds, app launchers). Every LSP
-- server spawned by nvim inherits this, so fix it once, here, globally.
vim.env.PATH = vim.env.PATH .. ":/etc/profiles/per-user/" .. vim.env.USER .. "/bin"

vim.pack.add({
	"https://github.com/folke/lazydev.nvim",
	"https://github.com/neovim/nvim-lspconfig",
})

require("lazydev").setup({
	-- library = {
	--   { path = "${3rd}/luv/library", words = { "vim%.uv" } },
	-- },
})

-- lua
vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml", ".git" },
	capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
		workspace = { didChangeWatchedFiles = { dynamicRegistration = false } }, -- kills file-watcher CPU churn
	}),
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
})

-- python: type checking + completions
vim.lsp.config("basedpyright", {
	settings = {
		basedpyright = { analysis = { diagnosticMode = "openFilesOnly", typeCheckingMode = "standard" } },
		python = { analysis = { autoImportCompletions = true } },
	},
})

vim.lsp.config("bashls", {
	filetypes = { "bash", "sh", "zsh" }, -- default is just { 'bash', 'sh' }
})

vim.lsp.config("tinymist", {
	settings = {
		-- exportPdf = "onSave", -- "onSave" | "onType" | "never"
	},
})

vim.lsp.enable({ "lua_ls", "basedpyright", "ruff", "qmlls", "bashls", "nixd", "tinymist", "rust_analyzer", "nushell" })
