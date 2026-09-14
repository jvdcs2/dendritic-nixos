vim.pack.add({ "https://github.com/andymass/vim-matchup" })

vim.g.matchup_matchparen_offscreen = {
	method = "popup",
} -- Show offscreen pairs in a popup window
vim.g.matchup_matchparen_deferred = 0 -- Forces instant highlight updates instead of waiting for cursor pauses.
vim.g.matchup_matchparen_timeout = 50 -- Stops highlighting execution after 50ms to prevent editor lag.
vim.g.matchup_matchparen_insert_timeout = 20 -- Limits insert mode highlighting to 20ms to keep typing smooth.

local p = require("palette")
p.set("MatchParen", {
	fg = p.fg,
	-- bold = true,
	bg = p.bg,
	underline = true,
})
