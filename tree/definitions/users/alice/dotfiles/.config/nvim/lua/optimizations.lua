vim.loader.enable()

-- Cap ShaDa history limits to prevent disk I/O stutter on startup and quit
vim.opt.shada = {
	"'20", -- Max files with marks saved (default: 100)
	"<50", -- Max lines saved per register (default: 1000)
	"s10", -- Max size of an item in KB (default: 10)
	"h", -- Disable search highlight restore on startup (default: enabled)
}

---- Disable unused legacy Vimscript plugins and executable checks on boot
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1

vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
