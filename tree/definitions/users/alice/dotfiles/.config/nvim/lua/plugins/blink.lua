vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/saghen/blink.lib" },
})

require("blink.cmp").setup({
	fuzzy = { implementation = "lua" },

	-- Insert mode
	keymap = {
		preset = "default",
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<CR>"] = { "accept", "fallback" },
	},

	-- Command-line mode (":" commands) — separate config tree from insert mode
	cmdline = {
		keymap = {
			preset = "cmdline",
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<Tab>"] = { "accept", "fallback" },
		},
		completion = {
			menu = { auto_show = true },
			list = { selection = { preselect = true, auto_insert = false } },
			ghost_text = { enabled = true }, -- inline preview of the top match as you type
		},
	},

	completion = {
		menu = {
			auto_show = true,
			border = "rounded", -- box the popup menu ("none"/"single"/"double"/"rounded")

			-- draw = {
			--   -- nvim-cmp-style layout: icon + kind name as a right-aligned column
			--   columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
			--   treesitter = { "lsp" },        -- treesitter-highlight the label text for lsp items
			-- },
		},

		list = {
			selection = { preselect = true, auto_insert = false },
			cycle = { from_top = true, from_bottom = true },
		},

		documentation = {
			-- hover-style preview of the selected item, shown as a second floating
			-- window beside the menu. It's an extra box competing for screen space,
			-- so pair it with a border below so it doesn't visually blur into the menu.
			auto_show = true,
			auto_show_delay_ms = 200,
			window = { border = "rounded" },
		},

		-- ghost_text = {
		--   -- inline "preview" of the selected item as virtual text in the buffer,
		--   -- instead of a floating menu. The docs treat this as an ALTERNATIVE to
		--   -- menu.auto_show, not a companion to it — running both at once shows a
		--   -- popup AND inline text simultaneously, which is busy/redundant.
		--   -- If enabling this, also set completion.menu.auto_show = false above
		--   -- and trigger the menu manually with <C-space> instead.
		--   enabled = true,
		-- },
	},

	-- signature = {
	--   -- function-signature popup while typing inside call parens, e.g. foo(|)
	--   -- Still marked experimental upstream as of v1.10.2 — works fine with most
	--   -- LSPs but isn't considered fully stable yet, so treat as opt-in.
	--   enabled = true,
	--   window = { border = "single" },
	-- },

	-- appearance = {
	--   -- "mono" or "normal" — must match whichever Nerd Font variant your
	--   -- terminal actually has installed. If kind icons (the little function/
	--   -- variable symbols) aren't rendering at all, that's a missing Nerd Font
	--   -- in your terminal, not a config bug — this setting won't fix that part.
	--   nerd_font_variant = "mono",
	--   -- Falls back to nvim-cmp's highlight groups when your colorscheme has
	--   -- no blink.cmp-specific highlights defined. Harmless to leave on.
	--   use_nvim_cmp_as_default = true,
	-- },
})
