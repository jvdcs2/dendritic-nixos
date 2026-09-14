vim.pack.add({ "https://github.com/cbochs/grapple.nvim" })

require("grapple").setup({
	scope = "git", -- "git" | "git_branch" | "cwd" | "global" — how tags are grouped per-project
	quick_select = "1234qwerasdfzxcv",
})
