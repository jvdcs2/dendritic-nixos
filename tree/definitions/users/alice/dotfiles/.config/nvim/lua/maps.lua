vim.g.mapleader = " "
vim.g.maplocalleader = " "

local S = vim.keymap.set

vim.keymap.set({ "n", "v" }, "gx", "<Nop>")
vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, { desc = "LSP Hover Documentation" })

S({ "n", "x" }, "<A-s>", "$", { desc = "Go to first non-blank" })
S({ "n", "x" }, "<A-a>", "^", { desc = "Go to start of line" })
S({ "i" }, "<A-s>", "<C-o>$", { desc = "Go to start of line" })
S({ "i" }, "<A-a>", "<C-o>^", { desc = "Go to first non-blank" })

-- window navigation
S("n", "<leader>wh", "<C-w>h", { desc = "Window left" })
S("n", "<leader>wj", "<C-w>j", { desc = "Window down" })
S("n", "<leader>wk", "<C-w>k", { desc = "Window up" })
S("n", "<leader>wl", "<C-w>l", { desc = "Window right" })
S("n", "<leader>wH", "<C-w>H", { desc = "Window move left" })
S("n", "<leader>wJ", "<C-w>J", { desc = "Window move down" })
S("n", "<leader>wK", "<C-w>K", { desc = "Window move up" })
S("n", "<leader>wL", "<C-w>L", { desc = "Window move right" })
S("n", "<leader>ww", "<C-w>p", { desc = "Window previous" })

-- insert windows
S("n", "<leader>wd", "<C-w>v", { desc = "Insert Window right" })
S("n", "<leader>ws", "<C-w>s", { desc = "Insert Window down" })
-- S("n", "<leader>iwh", ":leftabove vsplit<CR>", { desc = "Insert Window left" })
-- S("n", "<leader>iwl", ":rightbelow vsplit<CR>", { desc = "Insert Window right" })
-- S("n", "<leader>iwk", ":leftabove split<CR>", { desc = "Insert Window up" })
-- S("n", "<leader>iwj", ":rightbelow split<CR>", { desc = "Insert Window down" })
-- S("n", "<leader>ith", ":leftabove vsplit | terminal<CR>", { desc = "Insert Terminal Window left" })
-- S("n", "<leader>itl", ":rightbelow vsplit | terminal<CR>", { desc = "Insert Terminal Window right" })
-- S("n", "<leader>itk", ":leftabove split | terminal<CR>", { desc = "Insert Terminal Window up" })
-- S("n", "<leader>itj", ":rightbelow split | terminal<CR>", { desc = "Insert Terminal Window down" })
-- S("n", "<leader>iwH", ":topleft vsplit<CR>", { desc = "Insert Window far left" })
-- S("n", "<leader>iwL", ":botright vsplit<CR>", { desc = "Insert Window far right" })
-- S("n", "<leader>iwK", ":topleft split<CR>", { desc = "Insert Window far up" })
-- S("n", "<leader>iwJ", ":botright split<CR>", { desc = "Insert Window far down" })

-- misc
S("n", "<leader>R", "<cmd>restart<CR>", { desc = "Restart Nvim" })
S("n", "<C-s>", "<cmd>write<CR>", { desc = "Save File" })

S("n", "<C-g>", function()
	require("dropbar.api").pick()
end, { desc = "Dropbar navigate" })

-- change cwd
S("n", "<leader>cd", "<cmd>cd %:p:h<CR>", { desc = "Change cwd to buffer's" })
S("n", "<leader>cl", "<cmd>lcd %:p:h<CR>", { desc = "Change cwd of current window to buffer's" })

-- yazi plugin
S({ "n", "v" }, "<C-space>", "<cmd>Yazi<cr>", { desc = "Open yazi at current file" })

-- ufo folding
S("n", "<C-h>", "zc", { desc = "Close current fold" })
S("n", "<C-l>", "zo", { desc = "Open current fold" })
local all_folds_closed = false
local function toggle_all_folds()
	if all_folds_closed then
		require("ufo").openAllFolds()
	else
		require("ufo").closeAllFolds()
	end
	all_folds_closed = not all_folds_closed
end
S("n", "<C-f>", toggle_all_folds, { desc = "Toggle all folds" })
-- vim.keymap.set("n", "<C-l>", function()
-- 	return require("fold-cycle").open()
-- end, { silent = true, desc = "Fold-cycle: open folds" })
-- vim.keymap.set("n", "<C-h>", function()
-- 	return require("fold-cycle").close()
-- end, { silent = true, desc = "Fold-cycle: close folds" })
-- vim.keymap.set("n", "<C-f>", function()
-- 	return require("fold-cycle").toggle_all()
-- end, { remap = true, silent = true, desc = "Fold-cycle: toggle all folds" })

-- snacks
-- S("n", "<C-p>", "<cmd>lprev<CR>", { desc = "Prev location item" })
-- S("n", "<C-n>", "<cmd>lnext<CR>", { desc = "Next location item" })
S("n", "<C-p>", "<cmd>cprev<CR>", { desc = "Prev quickfix item" })
S("n", "<C-n>", "<cmd>cnext<CR>", { desc = "Next quickfix item" })
S("n", "<leader>e", function()
	local current_win = vim.api.nvim_get_current_win()
	local buf = vim.api.nvim_win_get_buf(current_win)
	local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })

	if ft == "snacks_picker_list" then
		-- We're in the explorer → go back to the previous window
		vim.cmd("wincmd p")
	else
		-- We're not in the explorer → find or open it
		local explorer_win = vim.tbl_filter(function(w)
			local b = vim.api.nvim_win_get_buf(w)
			return vim.api.nvim_get_option_value("filetype", { buf = b }) == "snacks_picker_list"
		end, vim.api.nvim_list_wins())[1]

		if explorer_win then
			vim.api.nvim_set_current_win(explorer_win)
		else
			Snacks.picker.explorer()
		end
	end
end, { desc = "Toggle focus between explorer and last window" })

S("n", "<leader>f", function()
	Snacks.picker.files({ cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(0)) })
end, { desc = "Find files in current buffer's dir" })
S("n", "<leader>F", function()
	Snacks.picker.files({ cwd = Snacks.git.get_root() })
end, { desc = "Find files in root" })

S("n", "<leader>/", function()
	Snacks.picker.grep({ cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(0)) })
end, { desc = "Grep cwd" })
S("n", "<leader>?", function()
	Snacks.picker.grep()
end, { desc = "Grep in current buffer's dir" })

S("n", "<leader>b", function()
	Snacks.picker.buffers()
end, { desc = "Search buffer list" })
S("n", "<leader>h", function()
	Snacks.picker.help()
end, { desc = "Search help tags" })
S("n", "<leader>'", function()
	Snacks.picker.resume()
end, { desc = "Resume previous picker" })

S("n", "<leader>H", function()
	Snacks.picker.highlights()
end, { desc = "Search highlights" })
S("n", "<leader>.", function()
	Snacks.picker.smart()
end, { desc = "Open smart picker" })

-- grapple
-- grapple
S("n", "<leader><", function()
	require("grapple").toggle()
end, { desc = "Grapple toggle tag" })
S("n", "<leader>,", function()
	require("grapple").toggle_tags()
end, { desc = "Grapple open list" })
-- S("n", "<leader>ga", function()
-- 	require("grapple").select({ index = 1 })
-- end, { desc = "Grapple file 1" })
-- S("n", "<leader>gs", function()
-- 	require("grapple").select({ index = 2 })
-- end, { desc = "Grapple file 2" })
-- S("n", "<leader>gd", function()
-- 	require("grapple").select({ index = 3 })
-- end, { desc = "Grapple file 3" })
-- S("n", "<leader>gf", function()
-- 	require("grapple").select({ index = 4 })
-- end, { desc = "Grapple file 4" })

-- multicursor-nvim
S({ "n", "v" }, "<A-n>", function()
	require("multicursor-nvim").matchAddCursor(1)
end, { desc = "Add next match cursor" })
S({ "n", "v" }, "<A-N>", function()
	require("multicursor-nvim").matchAddCursor(-1)
end, { desc = "Add next match cursor" })
-- S({ "n", "v" }, "<C-s>", function() require("multicursor-nvim").matchSkipCursor(1) end, { desc = "Skip match cursor" })
-- S({ "n", "v" }, "<C-Up>", function() require("multicursor-nvim").lineAddCursor(-1) end, { desc = "Add cursor above" })
-- S({ "n", "v" }, "<C-Down>", function() require("multicursor-nvim").lineAddCursor(1) end, { desc = "Add cursor below" })
S("n", "<Esc>", function()
	if require("multicursor-nvim").hasCursors() then
		require("multicursor-nvim").clearCursors()
	else
		vim.cmd("nohlsearch")
	end
end, { desc = "Clear cursors" })

-- maps escape to exit terminal-insert mode
S("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

-- nvim-surround
vim.keymap.set("x", "S", function()
	-- wait silently for exactly one keypress
	local char = vim.fn.getcharstr()
	-- exit safely after hitting escape or enter
	if char == "\27" or char == "\r" then
		return
	end
	require("visual-surround").surround(char)
end, { desc = "Surround visual selection" })

-- mini-bufdelete
vim.keymap.set("n", "<leader>db", function()
	require("mini.bufremove").delete(0, false) -- (0 = current buffer, false = don't force write/discard)
end, { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>dw", "<C-w>c", { desc = "Delete Window" })

-- typst preview
vim.keymap.set("n", "<leader>tp", ":TypstPreview<CR>", { desc = "Start typst preview" })
vim.keymap.set("n", "<leader>ts", ":TypstPreviewStop<CR>", { desc = "Stop typst preview" })
vim.keymap.set("n", "<leader>tt", ":TypstPreviewToggle<CR>", { desc = "Toggle Typst preview" })
vim.keymap.set("n", "<leader>ted", ':w !typst compile "%" "%:r.pdf"<CR>', { desc = "Export to PDF" })
vim.keymap.set("n", "<leader>tep", ':w !typst compile "%" "%:r.png" --format png<CR>', { desc = "Export to PNG" })

-- treesitter navigation
local map = { H = "an", L = "in", J = "]n", K = "[n" }
for key, seq in pairs(map) do
	vim.keymap.set("n", "" .. key .. "", function()
		vim.api.nvim_feedkeys("v" .. seq, "m", false)
	end)
	vim.keymap.set("v", "" .. key .. "", function()
		vim.api.nvim_feedkeys(seq, "m", false)
	end)
end
