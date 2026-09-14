return {
	bg = "#1a1a19",
	fg = "#d1d1d1",
	gray01 = "#222221",
	gray02 = "#2a2a29",
	gray03 = "#323231",
	gray04 = "#4b4b4a",
	gray05 = "#6c6c6a",
	gray06 = "#767675",
	blue = "#86adcd",
	cyan = "#499294",
	green = "#60967d",
	yellow = "#ffc591",
	red = "#ff968c",
	magenta = "#de9bc8",

	set = function(highlight_group, config)
		vim.api.nvim_set_hl(0, highlight_group, config)
	end,

	set_multi = function(self, ab_pairs)
		for _, ab in ipairs(ab_pairs) do
			self.set(ab[1], ab[2])
		end
	end,
}
