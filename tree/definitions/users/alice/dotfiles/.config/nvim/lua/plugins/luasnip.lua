vim.pack.add({ "https://github.com/L3MON4D3/LuaSnip" })

local LUASNIP = require("luasnip")
LUASNIP.setup({
	history = true, -- When enabled, allows you to jump back into snippets you've already exited. This is very popular in configurations like LazyVim.
	enable_autosnippets = true, -- Enables snippets that expand automatically when you type their trigger text (no need to press a key to expand). This is commonly enabled for LaTeX and other writing workflows.
	delete_check_events = "TextChanged", -- Automatically removes snippet history when you delete the snippet's text. This is a common fix for placeholder marks lingering after deletion.
	region_check_events = "CursorHold,InsertLeave", -- Automatically exits a snippet if you move the cursor outside its region. Prevents you from jumping back into snippets you've moved away from.
	update_events = "TextChanged,TextChangedI", -- Updates snippet placeholders and dependent nodes on every text change instead of only when you leave insert mode.
	store_selection_keys = "<Tab>", -- Sets a keymap to populate the `TM_SELECTED_TEXT` variable with your visual selection, so snippets can use it.
	ext_opts = { -- Adds passive/active highlighting to snippet nodes, making it visually clear which part of the snippet you're editing.
		active = { hl_group = "GruvboxRed" },
	},
	strict = false, -- Warns about unused nodes. Some users disable this to reduce noise.
	trim_empty = false, -- Removes empty first/last lines when using multiline strings with `fmt`. Some users disable this to preserve exact formatting.
})

require("luasnip").log.set_loglevel("info") -- Controls how much information LuaSnip logs to `luasnip.log`. Useful when snippets aren't loading correctly.

--

local ls = require("luasnip")
local nt = require("neotab")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmta = require("luasnip.extras.fmt").fmta

vim.keymap.set({ "i", "s" }, "<Tab>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	else -- HACK: to not conflict with neotab
		nt.tabout()
	end
end, { silent = true })

-- Map <S-Tab> to jump to the previous placeholder
vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	else -- HACK: to not conflict with neotab
		nt.tabreverse()
	end
end, { silent = true })

local function in_math()
	local cur = vim.api.nvim_win_get_cursor(0)
	local lines = vim.api.nvim_buf_get_lines(0, 0, cur[1], false)
	table.insert(lines, vim.api.nvim_get_current_line():sub(1, cur[2]))
	local n = 0
	for _, l in ipairs(lines) do
		for _ in l:gsub("\\%$", ""):gmatch("%$") do
			n = n + 1
		end
	end
	return n % 2 == 1
end

local function ms(trig, nodes, opts)
	return s(
		vim.tbl_extend("force", {
			trig = trig,
			snippetType = "autosnippet",
			condition = in_math,
			wordTrig = false,
		}, opts or {}),
		nodes
	)
end

local function ts(trig, nodes, opts)
	return s(
		vim.tbl_extend("force", {
			trig = trig,
			snippetType = "autosnippet",
			wordTrig = false,
		}, opts or {}),
		nodes
	)
end

ls.add_snippets("typst", {
	-- Containers
	ms("ss", fmta([["<>"<>]], { i(1), i(0) })),
	ts("aa", fmta("$<>$", { i(1) })),
	ts("bb", fmta("*<>*", { i(1) })),
	ms("ee", fmta("_<>_<>", { i(1), i(0) })),

	-- Logic
	ms("=v", t("arrow.b.double ")),
	ms("===", t("equiv")),
	ms("fa", t("forall")),
	ms("te", t("exists")),
	ms("sor", t("union")),
	ms("sand", t("inter")),

	-- Operators
	ms("+-", t("plus.minus")),
	ms("-+", t("plus.minus")),
	ms("^", fmta("^(<>)<>", { i(1), i(0) })),
	ms("_", fmta("_(<>)<>", { i(1), i(0) })),

	ms("//", fmta("frac(<>, <>)<>", { i(1, "a"), i(2, "b"), i(0) })),

	-- Calculus
	ms("lim", fmta("lim_(<> ->> <>) <>", { i(1, "n"), i(2, "oo"), i(0) })),
	ms("sum", fmta("sum_(<>=<>)^<> <>", { i(1, "n"), i(2, "1"), i(3, "oo"), i(0) })),
	ms("prod", fmta("product_(<>=<>)^<> <>", { i(1, "n"), i(2, "1"), i(3, "oo"), i(0) })),
	ms("int", fmta("integral <> dif <> <>", { i(1), i(2, "x"), i(0) })),
	ms("der", fmta("frac(dif <>, dif <>)<>", { i(1), i(2), i(3) })),
	ms("pder", fmta("frac(partial <>, partial <>) <>", { i(1, "y"), i(2, "x"), i(0) })),
}, { key = "typst" })
