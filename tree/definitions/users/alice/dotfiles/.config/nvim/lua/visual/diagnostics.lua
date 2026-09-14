vim.diagnostic.config({
	-- Completely disables multiline buffer-shifting lines
	virtual_lines = false,
	underline = {
		severity = vim.diagnostic.severity.HINT,
	},

	-- Displays diagnostics on the SAME line at the far right
	virtual_text = {
		current_line = true, -- Only shows diagnostic for the active cursor line
		prefix = "■ ", -- Clean glyph preceding the diagnostic text
		spacing = 1, -- Gap between the end of your code and the message
	},
})
