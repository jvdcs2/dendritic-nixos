vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })
require("gitsigns").setup()

vim.o.laststatus = 2
vim.o.showcmdloc = "statusline"

local CAPL, CAPR = "", ""
local p = require("palette")

-- Single source of truth for the statusline's central fill color.
-- Used for the 'StatusLine' highlight and any inward-facing caps.
local STL_BG = p.gray02

p:set_multi({
	{ "StatusLine", { fg = p.fg, bg = STL_BG } },
})

-- ============================================================
-- Generic pill builder: [left cap][ text ][right cap].
-- Text uses the pill's background color.
-- Caps are explicitly told what color to blend OUTWARD into
-- (e.g., p.bg for true edges, STL_BG for inner fill) directly
-- at the call site, eliminating baked-in highlight groups.
-- ============================================================
local hl_cache = {}
local hl_id = 0
local function hl(fg, bg, bold)
	local key = fg .. "|" .. bg .. "|" .. tostring(bold)
	local name = hl_cache[key]
	if not name then
		hl_id = hl_id + 1
		name = "StPill" .. hl_id
		vim.api.nvim_set_hl(0, name, { fg = fg, bg = bg, bold = bold })
		hl_cache[key] = name
	end
	return name
end

--- @param text string        Pill text, including padding
--- @param fg string          Text color
--- @param bg string          Pill fill color
--- @param left_outer string  Color LEFT cap blends into (p.bg = true edge, STL_BG = inner fill)
--- @param right_outer string Color RIGHT cap blends into (p.bg = true edge, STL_BG = inner fill)
--- @param bold boolean|nil
local function pill(text, fg, bg, left_outer, right_outer, bold)
	local text_hl = hl(fg, bg, bold)
	local left_hl = hl(bg, left_outer, false)
	local right_hl = hl(bg, right_outer, false)
	return "%#"
		.. left_hl
		.. "#"
		.. CAPL
		.. "%#"
		.. text_hl
		.. "#"
		.. text
		.. "%#"
		.. right_hl
		.. "#"
		.. CAPR
		.. "%#StatusLine#"
end

-- Mode mappings: label, pill bg, text fg
local modes = {
	n = { "N", p.gray04, p.fg },
	i = { "I", p.blue, p.bg },
	v = { "V", p.green, p.bg },
	[""] = { "V", p.green, p.bg },
	V = { "VL", p.green, p.bg },
	c = { "C", p.red, p.bg },
	R = { "R", p.blue, p.bg },
	t = { "T", p.green, p.bg },
}

_G.Statusline = {}

function _G.Statusline.mode()
	-- win_getid() returns the window currently drawing the statusline.
	-- g:actual_curwin is the actual focused window. Coerce it to a number before comparing.
	if vim.fn.win_getid() ~= tonumber(vim.g.actual_curwin) then
		-- Unfocused window: return empty pill using p.bg fill to maintain cap rendering.
		return pill("   ", p.fg, p.gray02, p.bg, STL_BG, true) .. " "
	end
	local m = modes[vim.fn.mode()] or { vim.fn.mode(), p.gray04, p.fg }
	local label, bg, fg = m[1], m[2], m[3]

	-- Leftmost pill: left cap faces true edge, right cap faces inner fill.
	return pill(" " .. label .. " ", fg, bg, p.bg, STL_BG, true) .. " "
end

local function truncate(str, max_len)
	if vim.fn.strchars(str) <= max_len then
		return str
	end
	-- truncate and append ellipsis
	return vim.fn.strpart(str, 0, max_len) .. "…"
end

function _G.Statusline.branch()
	local text
	if vim.b.gitsigns_head then
		text = vim.b.gitsigns_head
	else
		-- text = "  " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. "  "
		text = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	end

	-- Rightmost pill: left cap faces inner fill, right cap faces true edge.
	return pill(truncate(" " .. text .. " ", 10), p.fg, p.gray04, STL_BG, p.bg, true)
end

vim.o.statusline = "%{%v:lua.Statusline.mode()%}%=%t %m%=%{%v:lua.Statusline.branch()%}"
