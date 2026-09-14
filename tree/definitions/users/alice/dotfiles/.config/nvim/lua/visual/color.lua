vim.cmd("hi clear")
vim.o.termguicolors = true
vim.g.colors_name = "helix-port"

local p = require("palette")
p:set_multi({
	-- treesitter captures that diverge from what they'd otherwise inherit
	{ "@spell.markdown", { fg = p.fg, bg = p.bg, underline = false } }, -- docs text

	{ "@variable", { fg = p.fg, underline = false } },
	{ "@variable.builtin", { fg = p.fg, italic = true } },
	{ "@variable.parameter", { fg = p.blue, italic = true } },
	{ "@variable.member", { fg = p.fg } },
	{ "@module", { fg = p.fg, underline = true } },
	{ "@function.macro", { fg = p.green, italic = true } },
	{ "@punctuation.bracket", { fg = p.gray04 } },
	{ "@punctuation.delimiter", { fg = p.gray04 } },
	{ "@string.regexp", { fg = p.blue } },
	{ "@string.special", { fg = p.blue } },

	{ "MyHeirlinePill", { bg = p.gray02 } },
	{ "MyHeirlineBg", { bg = p.bg } },

	{ "Normal", { fg = p.fg } },
	{ "NormalFloat", { fg = p.gray04, bg = p.bg } },
	{ "FloatBorder", { fg = p.gray03, bg = p.bg } },
	{ "WinSeparator", { fg = p.gray03 } },
	{ "LineNr", { fg = p.gray03 } },
	{ "CursorLineNr", { fg = p.fg } },
	{ "CursorLine", { bg = p.gray01 } },
	{ "CursorColumn", { bg = p.gray01 } },

	{ "Visual", { fg = p.fg, bg = p.gray03 } },

	{ "Search", { fg = p.fg, bg = p.gray03 } },
	{ "IncSearch", { fg = p.bg, bg = p.fg } },
	{ "MatchParen", { fg = p.fg, bg = p.gray04 } },
	{ "Cursor", { fg = p.bg, bg = p.fg } },
	{ "StatusLine", { fg = p.fg, bg = p.gray02 } },

	{ "StatusLineNC", { fg = p.gray05, bg = p.bg } }, -- status line plit at window boundary

	{ "TabLine", { fg = p.gray04 } },
	{ "TabLineSel", { fg = p.fg, bg = p.gray02 } },
	{ "TabLineFill", { fg = p.gray04 } },
	{ "Pmenu", { fg = p.fg, bg = p.gray01 } },
	{ "PmenuSel", { fg = p.bg, bg = p.fg } },
	{ "PmenuThumb", { bg = p.gray04 } },

	{ "Directory", { fg = p.blue } }, -- set to blue for snacksexplorer (see snacks section below)

	{ "NonText", { fg = p.gray03 } },
	{ "ErrorMsg", { fg = p.red, italic = true } },
	{ "WarningMsg", { fg = p.yellow, italic = true } },

	-- diagnostics
	{ "DiagnosticError", { fg = p.red, italic = true } },
	{ "DiagnosticWarn", { fg = p.yellow, italic = true } },
	{ "DiagnosticInfo", { fg = p.blue, italic = true } },
	{ "DiagnosticHint", { fg = p.green, italic = true } },
	{ "DiagnosticUnderlineError", { sp = p.red, undercurl = true } },
	{ "DiagnosticUnderlineWarn", { sp = p.yellow, underline = true } },
	{ "DiagnosticUnderlineInfo", { sp = p.blue, underline = true } },
	{ "DiagnosticUnderlineHint", { sp = p.green, underline = true } },

	-- diff: fg-only, matching Helix's diff.plus/minus/delta gutter glyphs.
	{ "DiffAdd", { fg = p.green } },
	{ "DiffDelete", { fg = p.red } },
	{ "DiffChange", { fg = p.magenta } },
	{ "DiffText", { fg = p.yellow } },

	-- base syntax groups
	{ "Comment", { fg = p.gray04, italic = true } },
	{ "Constant", { fg = p.white } },
	{ "String", { fg = p.cyan, italic = true } },
	{ "Identifier", { fg = p.fg } },
	{ "Function", { fg = p.green } },
	{ "Statement", { fg = p.gray06 } },
	{ "Operator", { fg = p.gray06, italic = true } },
	{ "PreProc", { fg = p.gray06 } },
	{ "Type", { fg = p.blue } },
	{ "Special", { fg = p.fg, italic = true } },
	{ "Delimiter", { fg = p.gray04 } },
	{ "Error", { fg = p.red, italic = true } },

	-- Snacks.nvim UI (Picker & Components)
	{ "SnacksPicker", { link = "Normal" } },
	{ "SnacksPickerInput", { link = "Normal" } },
	{ "SnacksPickerList", { link = "Normal" } },
	{ "SnacksPickerPreview", { link = "Normal" } },
	{ "SnacksPickerBorder", { link = "FloatBorder" } },
	{ "SnacksPickerInputBorder", { link = "FloatBorder" } },
	{ "SnacksPickerListBorder", { link = "FloatBorder" } },
	{ "SnacksPickerPreviewBorder", { link = "FloatBorder" } },

	{ "SnacksPickerMatch", { fg = p.green, italic = true } }, -- Matched characters in search results
	{ "SnacksPickerSelected", { fg = p.fg, bg = p.gray02 } }, -- Active row highlight
	{ "SnacksPickerTree", { fg = p.gray04 } },

	{ "SnacksPickerDir", { fg = p.gray05 } }, -- Dims the path in pickers
	{ "SnacksPickerDirectory", { fg = p.blue } },
	{ "SnacksPickerPathHidden", { fg = p.fg, italic = true } },

	{ "SnacksPickerIconKey", { fg = p.blue } },

	{ "SnacksPickerFile", { fg = p.fg } }, -- Keeps trailing filename bright

	{ "SnacksPickerTitle", { fg = p.fg } },
	{ "SnacksPickerInputTitle", { fg = p.fg } },
	{ "SnacksPickerListTitle", { fg = p.fg } },
	{ "snackspickerpreviewtitle", { fg = p.fg } },

	-- WhichKey UI & Background
	{ "WhichKeyNormal", { bg = p.bg } },
	{ "WhichKeyBorder", { link = "FloatBorder" } },
	{ "WhichKeyValue", { fg = p.blue } },

	-- nvim-notify UI
	{ "NotifyBackground", { bg = p.bg } },
	{ "NotifyERRORBorder", { link = "FloatBorder" } },
	{ "NotifyERRORIcon", { fg = p.red } },
	{ "NotifyERRORTitle", { fg = p.red, italic = true } },

	{ "NotifyWARNBorder", { link = "FloatBorder" } },
	{ "NotifyWARNIcon", { fg = p.yellow } },
	{ "NotifyWARNTitle", { fg = p.yellow, italic = true } },

	{ "NotifyINFOBorder", { link = "FloatBorder" } },
	{ "NotifyINFOIcon", { fg = p.blue } },
	{ "NotifyINFOTitle", { fg = p.blue, italic = true } },

	{ "NotifyDEBUGBorder", { link = "FloatBorder" } },
	{ "NotifyDEBUGIcon", { fg = p.gray05 } },
	{ "NotifyDEBUGTitle", { fg = p.gray05, italic = true } },

	{ "NotifyTRACEBorder", { link = "FloatBorder" } },
	{ "NotifyTRACEIcon", { fg = p.magenta } },
	{ "NotifyTRACETitle", { fg = p.magenta, italic = true } },

	-- Folding (Native Neovim & nvim-ufo)
	{ "Folded", { fg = p.gray05, bg = p.gray01 } },
	{ "FoldColumn", { fg = p.gray04 } },

	{ "UfoFoldedFg", { fg = p.gray05 } },
	{ "UfoFoldedBg", { bg = p.gray01 } },
	{ "UfoFoldedEllipsis", { fg = p.blue } },
	{ "UfoPreviewNormal", { link = "NormalFloat" } },
	{ "UfoPreviewBorder", { link = "FloatBorder" } },

	-- Native Neovim Winbar
	{ "WinBar", { link = "Normal" } },
	{ "WinBarNC", { link = "Normal" } },

	-- DropBar
	{ "DropBarMenuNormalFloat", { fg = p.fg, bg = p.gray01 } },
	{ "DropBarMenuCurrentContext", { fg = p.fg, bg = p.gray03, bold = true } },
	{ "DropBarMenuHover", { fg = p.fg, bg = p.gray02, bold = true } },
	{ "DropBarMenuSbar", { bg = p.gray02 } },
	{ "DropBarMenuThumb", { bg = p.gray04 } },

	{ "DropBarMenuHoverEntry", { fg = p.bg, bg = p.fg } },
	{ "DropBarMenuHoverSymbol", { fg = p.bg, bg = p.fg, bold = true } },
	{ "DropBarMenuHoverIcon", { fg = p.bg, bg = p.fg } },

	-- Gitsigns
	{ "GitSignsAdd", { fg = p.green, bg = "NONE", blend = 0 } },
	{ "GitSignsChange", { fg = p.magenta, bg = "NONE", blend = 0 } },
	{ "GitSignsDelete", { fg = p.red, bg = "NONE", blend = 0 } },
	{ "GitSignsChangedelete", { fg = p.magenta, bg = "NONE", blend = 0 } },
	{ "GitSignsTopdelete", { fg = p.red, bg = "NONE", blend = 0 } },
	{ "GitSignsUntracked", { fg = p.cyan, bg = "NONE", blend = 0 } },
	{ "SignColumn", { bg = "NONE" } },

	-- Noice
	{ "NoicePopup", { fg = p.fg } },
	{ "NoiceCmdlinePopupBorder", { fg = p.gray03 } },
	{ "NoiceCmdlinePopupBorderSearch", { fg = p.gray03 } },
	{ "NoiceCmdlinePopupTitle", { fg = p.fg } },
	{ "NoiceCmdlinePopupTitleCmdline", { fg = p.fg } },
	{ "NoiceCmdlinePopupTitleSearch", { fg = p.yellow } },
	{ "NoiceLspProgressTitle", { fg = p.gray04 } },

	-- blink.cmp
	{ "BlinkCmpMenu", { fg = p.fg, bg = p.bg } },
	{ "BlinkCmpMenuBorder", { link = "FloatBorder" } },
	{ "BlinkCmpMenuSelection", { bg = p.gray02 } },
	{ "BlinkCmpLabel", { fg = p.fg } },
	{ "BlinkCmpLabelMatch", { fg = p.green, italic = true } },
	{ "BlinkCmpLabelDeprecated", { fg = p.gray05, strikethrough = true } },
	{ "BlinkCmpLabelDescription", { fg = p.gray05 } },
	{ "BlinkCmpLabelDetail", { fg = p.gray05 } },
	{ "BlinkCmpGhostText", { fg = p.gray04 } },
	{ "BlinkCmpDoc", { fg = p.fg } },
	{ "BlinkCmpDocBorder", { link = "FloatBorder" } },
	{ "BlinkCmpDocSeparator", { fg = p.gray03 } },
	{ "BlinkCmpSignatureHelp", { link = "NormalFloat" } },
	{ "BlinkCmpSignatureHelpBorder", { link = "FloatBorder" } },
	{ "BlinkCmpSignatureHelpActiveParameter", { fg = p.yellow, bold = true } },
	{ "BlinkCmpKind", { fg = p.gray05 } },
	{ "BlinkCmpKindText", { fg = p.fg } },
	{ "BlinkCmpKindMethod", { fg = p.green } },
	{ "BlinkCmpKindFunction", { fg = p.green } },
	{ "BlinkCmpKindConstructor", { fg = p.green } },
	{ "BlinkCmpKindField", { fg = p.fg } },
	{ "BlinkCmpKindVariable", { fg = p.fg } },
	{ "BlinkCmpKindProperty", { fg = p.fg } },
	{ "BlinkCmpKindClass", { fg = p.blue } },
	{ "BlinkCmpKindInterface", { fg = p.blue } },
	{ "BlinkCmpKindStruct", { fg = p.blue } },
	{ "BlinkCmpKindModule", { fg = p.blue, underline = true } },
	{ "BlinkCmpKindEnum", { fg = p.blue } },
	{ "BlinkCmpKindEnumMember", { fg = p.magenta } },
	{ "BlinkCmpKindKeyword", { fg = p.gray06 } },
	{ "BlinkCmpKindOperator", { fg = p.gray06, italic = true } },
	{ "BlinkCmpKindTypeParameter", { fg = p.blue, italic = true } },
	{ "BlinkCmpKindConstant", { fg = p.magenta } },
	{ "BlinkCmpKindValue", { fg = p.magenta } },
	{ "BlinkCmpKindSnippet", { fg = p.yellow } },
	{ "BlinkCmpKindFile", { fg = p.gray05 } },
	{ "BlinkCmpKindFolder", { fg = p.gray05 } },
	{ "BlinkCmpKindReference", { fg = p.cyan } },
	{ "BlinkCmpKindColor", { fg = p.cyan } },
	{ "BlinkCmpKindUnit", { fg = p.cyan } },
	{ "BlinkCmpKindEvent", { fg = p.red } },
	{ "BlinkCmpSource", { fg = p.gray05, italic = true } },
})
