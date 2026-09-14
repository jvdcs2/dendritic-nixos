vim.pack.add({ "https://github.com/windwp/nvim-autopairs" })

local nvim_autopairs = require("nvim-autopairs")
nvim_autopairs.setup({
	-- Default settings (uncomment/edit to change)
	-- enable_moveright = true,          -- Move past closing bracket when typed
	-- enable_afterquote = true,          -- Add bracket after quote
	-- enable_check_bracket_line = true,  -- Don't add pair if bracket on same line
	check_ts = true, -- Enable Treesitter integration
	-- map_bs = true,                     -- Map backspace to delete pairs
	-- map_c_w = false,                   -- Map Ctrl+W to delete pairs
})

local rule = require("nvim-autopairs.rule")
nvim_autopairs.add_rules({
	-- rule("$", "$"), -- typing $ inserts $$ with cursor between them
})
