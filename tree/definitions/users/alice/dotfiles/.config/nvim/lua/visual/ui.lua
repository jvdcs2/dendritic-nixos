vim.opt.fillchars:append({ eob = " " })
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"

local diag_icons = {
	[vim.diagnostic.severity.ERROR] = "*",
	[vim.diagnostic.severity.WARN] = "*",
	[vim.diagnostic.severity.INFO] = "*",
	[vim.diagnostic.severity.HINT] = "*",
}
local diag_hl = {
	[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
	[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
	[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
	[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
}

vim.diagnostic.config({
	signs = false, -- stop diagnostics claiming the sign column; we render them ourselves, before the number
})

_G.diagnostic_statuscol = function()
	local lnum, relnum = vim.v.lnum, vim.v.relnum
	local diags = vim.diagnostic.get(0, { lnum = lnum - 1 })

	-- Diagnostic icon, colored, rendered before the number.
	-- Reserve 1 char even when empty so the number column doesn't shift.
	local diag_str = "  "
	if #diags > 0 then
		local severity = diags[1].severity
		diag_str = string.format("%%#%s#%s%%*", diag_hl[severity], diag_icons[severity])
	end

	-- Number: always relative, absolute only on the cursor line
	local num = (relnum == 0) and lnum or relnum
	-- Highlight: CursorLine Color -> Default Color (diagnostics never touch this)
	local hl = (relnum == 0) and "CursorLineNr" or "LineNr"

	-- diag icon (colored), right-aligned number (uncolored by diagnostics), then gitsigns
	return string.format("%s%%=%%#%s#%d%%* %%s", diag_str, hl, num)
end
vim.o.statuscolumn = "%!v:lua.diagnostic_statuscol()"
