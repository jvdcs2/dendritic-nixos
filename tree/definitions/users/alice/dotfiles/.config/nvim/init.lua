-- ORDER MATTERS
require("defaults")
require("maps")
require("optimizations")

require("visual.color")
require("visual.ui")
require("visual.noice") -- problematic
require("visual.diagnostics")
require("visual.statusbar")
require("visual.icons")
require("visual.dropbar")
require("visual.todo-comments")

require("plugins.nvim-lspconfig")
require("plugins.yazi")
require("plugins.which-key")
require("plugins.snacks")
require("plugins.multicursor")
require("plugins.nvim-ufo")
require("plugins.nvim-treesitter")

require("plugins.gitsigns")
require("plugins.blink")
require("plugins.toggleterm")

require("plugins.conform")
require("plugins.grapple")

require("plugins.typst-preview")

require("plugins.mini-bufdelete")
require("plugins.indent-blankline")
require("plugins.rainbow-delimiters")
require("plugins.vim-matchup")

require("plugins.visual-surround")

require("plugins.neotab") -- conflicts with luasnip
require("plugins.luasnip")
require("plugins.mini-pairs")
-- require("plugins.nvim-autopairs")

-- require("plugins.winshift")
-- require("plugins.hover")

require("plugins.yankassassin")
require("plugins.fold-cycle") -- WARN: crashes nvim
