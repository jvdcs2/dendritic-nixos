vim.pack.add({ "https://github.com/NStefan002/visual-surround.nvim" })

require("visual-surround").setup({
	use_default_keymaps = false, -- default: true (enables one-key mappings)
	-- exit_visual_mode = true,      -- default: true (exit visual after surround)
})
