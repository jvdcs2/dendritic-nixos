vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/mikavilpas/yazi.nvim",
})

require("yazi").setup({
	-- open_for_directories = true, -- true = yazi replaces netrw when you `:e` a directory
	open_multiple_tabs = true, -- true = open all visible splits as yazi tabs
	change_neovim_cwd_on_close = false, -- changes cwd if yazi exits without entering a file
	-- integrations = { -- for <C-s> inside yazi.nvim
	-- 	grep_in_directory = function(directory)
	-- 		-- Snacks.picker.grep({ cwd = directory })
	-- 	end,
	-- 	grep_in_selected_files = function(selected_files, relative_paths)
	-- 		-- Snacks.picker.grep({ search = selected_files })
	-- 	end,
	-- },
})
