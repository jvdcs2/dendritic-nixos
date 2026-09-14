vim.pack.add({
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/Bekaboo/dropbar.nvim",
})
local fzf_dir = vim.fn.stdpath("data") .. "/site/pack/core/opt/telescope-fzf-native.nvim"
local built = vim.uv.fs_stat(fzf_dir .. "/build/libfzf.so") or vim.uv.fs_stat(fzf_dir .. "/build/libfzf.dll")
if vim.uv.fs_stat(fzf_dir) and not built then
	if vim.fn.executable("make") == 1 then
		vim.fn.system({ "make", "-C", fzf_dir })
	else
		vim.notify("telescope-fzf-native: 'make' not found, skipping build", vim.log.levels.WARN)
	end
end

require("dropbar").setup({
	bar = {
		truncate = true,

		-- Ms to wait before redrawing on rapid updates
		-- update_debounce = 32,
		padding = { left = 1, right = 1 },
		pick = { pivots = "asdfghjklzxcvbnm,." }, -- keys shown in pick mode

		-- custom function makes dropbar appear even if the file has no treesitter support, NOTE: this is not a complex hack, this is just the edit of the actual function inside of dropbar.
		enable = function(buf, win, _)
			buf = vim._resolve_bufnr(buf)
			if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_win_is_valid(win) then
				return false
			end
			if vim.fn.win_gettype(win) ~= "" or vim.wo[win].winbar ~= "" or vim.bo[buf].ft == "help" then
				return false
			end
			local stat = vim.uv.fs_stat(vim.api.nvim_buf_get_name(buf))
			if stat and stat.size > 1024 * 1024 then
				return false
			end
			return true -- was: ft == 'markdown' or has treesitter parser
		end,
	},
	menu = {
		quick_navigation = true, -- jump cursor to nearest clickable entry on move
		preview = false, -- preview symbol in source window on hover
		hover = true, -- highlight entry under cursor
		entry = { padding = { left = 1, right = 1 } },
		win_configs = {
			border = "none",
		},
		-- scrollbar = { enable = true, background = true },
		keymaps = {
			h = "<C-w>q", -- go back / close submenu (same as default q/<Esc>)
			l = function()
				return require("dropbar.configs").opts.menu.keymaps["<CR>"]()
			end,
		},
	},
	icons = {
		ui = {
			bar = {
				separator = "  ",
			},
		},
	},
	sources = {
		path = { max_depth = 6 }, -- max path segments shown
		treesitter = { max_depth = 6 },
		lsp = { max_depth = 6 },
		markdown = { max_depth = 6 },
	},
})
