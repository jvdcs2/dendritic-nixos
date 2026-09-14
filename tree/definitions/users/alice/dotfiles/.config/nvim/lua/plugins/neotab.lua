vim.pack.add({ "https://github.com/kawre/neotab.nvim" })

require("neotab").setup({
	tabkey = "", -- key that triggers tab-out, "" to disable
	reverse_key = "", -- key that triggers tab-out backwards, "" to disable
	act_as_tab = true, -- if no pair to jump out of, falls back to a normal <Tab>
	behavior = "nested", -- "nested" (jump to closest pair) | "closing" (prioritize closing pair)
	pairs = { -- characters it will tab out of
		{ open = "(", close = ")" },
		{ open = "[", close = "]" },
		{ open = "{", close = "}" },
		{ open = "'", close = "'" },
		{ open = '"', close = '"' },
		{ open = "`", close = "`" },
		{ open = "<", close = ">" },
		{ open = "$", close = "$" },
	},
	exclude = {}, -- filetypes to disable this on
})
