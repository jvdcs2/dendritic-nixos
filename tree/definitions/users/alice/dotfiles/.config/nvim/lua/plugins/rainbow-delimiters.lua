vim.pack.add({ "https://github.com/HiPhish/rainbow-delimiters.nvim" })

require("rainbow-delimiters.setup").setup({
	-- strategy = {
	--   [''] = require('rainbow-delimiters').strategy['global'],
	-- },
	-- query = {
	--   [''] = 'rainbow-delimiters',
	-- },
	-- highlight = {
	--   'RainbowDelimiterRed',
	--   'RainbowDelimiterYellow',
	--   'RainbowDelimiterBlue',
	--   'RainbowDelimiterOrange',
	--   'RainbowDelimiterGreen',
	--   'RainbowDelimiterViolet',
	--   'RainbowDelimiterCyan',
	-- },
})

local p = require("palette")
p:set_multi({
	{ "RainbowDelimiterRed", { fg = p.gray05 } },
	{ "RainbowDelimiterYellow", { fg = p.gray04 } },
	{ "RainbowDelimiterBlue", { fg = p.gray05 } },
	{ "RainbowDelimiterOrange", { fg = p.gray04 } },
	{ "RainbowDelimiterGreen", { fg = p.gray05 } },
	{ "RainbowDelimiterViolet", { fg = p.gray04 } },
	{ "RainbowDelimiterCyan", { fg = p.gray05 } },
})
