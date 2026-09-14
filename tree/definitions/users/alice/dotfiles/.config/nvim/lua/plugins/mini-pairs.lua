vim.pack.add({ "https://github.com/nvim-mini/mini.pairs" })

require("mini.pairs").setup({
	-- modes = { insert = true, command = false, terminal = false }, -- active modes
	-- skip_next = [[%w%%%'%[%\"%.%`%$]],                            -- chars to skip pairing on
	-- skip_unbalanced = true,                                     -- don't close if unbalanced
	-- markdown = true,                                            -- handle markdown code blocks
})

-- vim.keymap.set("i", "<Tab>", function()
-- 	local line = vim.fn.getline(".")
-- 	local col = vim.fn.col(".")
-- 	-- Check if the character directly under/ahead of the cursor is a closer
-- 	if line:sub(col, col):match("[%)}%]\"'`>]") then
-- 		return "<Right>"
-- 	end
-- 	return "<Tab>"
-- end, { expr = true, silent = true })
