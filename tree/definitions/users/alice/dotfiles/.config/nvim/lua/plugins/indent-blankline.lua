vim.pack.add({ "https://github.com/lukas-reineke/indent-blankline.nvim" })

local highlight = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}

local hooks = require("ibl.hooks")
local p = require("palette")
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	p:set_multi({
		{ "RainbowRed", { fg = p.gray01 } },
		{ "RainbowYellow", { fg = p.gray01 } },
		{ "RainbowBlue", { fg = p.gray01 } },
		{ "RainbowOrange", { fg = p.gray01 } },
		{ "RainbowGreen", { fg = p.gray01 } },
		{ "RainbowViolet", { fg = p.gray01 } },
		{ "RainbowCyan", { fg = p.gray01 } },
	})
end)

require("ibl").setup({
	indent = {
		-- char = "│",
		highlight = highlight,
	},
	scope = {
		enabled = true,
		show_start = false,
		show_end = false,
	},
	-- exclude = {
	--   filetypes = { "help", "alpha", "dashboard", "lazy", "mason" },
	-- },
})
