vim.o.laststatus = 3
vim.opt.termsync = true
vim.opt.autoread = true
vim.opt.swapfile = false -- swapfile warnings
vim.opt.title = false -- disabled for term
vim.o.winborder = "rounded"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.wrap = true -- Enable line wrapping
vim.opt.breakindent = true -- Maintain indent level on wrapped lines
vim.opt.linebreak = true -- Break lines at words rather than hard boundaries
vim.opt.showbreak = "↪ "

-- Cursor
vim.opt.guicursor = {
	"n:block", -- normal: block cursor
	"i:ver25", -- insert: bar cursor
	"v:hor20", -- select/visual: underline cursor
}

vim.opt.tabstop = 2 -- Number of spaces that a <Tab> counts for
vim.opt.shiftwidth = 2 -- Number of spaces to use for each step of indent
vim.opt.softtabstop = 2 -- Number of spaces that a <Tab> counts for while performing editing operations
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.smartindent = true -- Automatically indent on new lines

vim.opt.number = true -- Enable absolute line numbers
vim.g.have_nerd_font = true
vim.opt.mouse = "a" -- enable mouse stuff

vim.opt.undofile = true -- Enable undo/redo changes even after closing and reopening a file

vim.opt.ignorecase = true -- Case insensitive search
vim.opt.smartcase = true -- same thing

vim.opt.clipboard = "unnamedplus" -- sync os and nvim clipboard
vim.opt.updatetime = 1

vim.opt.scrolloff = 12
-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
vim.opt.confirm = true
