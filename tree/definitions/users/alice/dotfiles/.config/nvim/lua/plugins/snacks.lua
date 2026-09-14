vim.pack.add({
	"https://github.com/folke/snacks.nvim",
})

require("snacks").setup({
	-- statuscolumn = {enabled=true},
	-- notifier = { enabled = true },
	-- animate = { enabled = true },
	explorer = {
		enabled = true,
		auto_update = true,
		replace_netrw = false,
	},
	picker = {
		enabled = true,
		prompt = "❯ ",
		formatters = {
			file = {
				filename_first = true,
			},
		},
		icons = {
			ui = {
				selected = "❯ ",
			},
		},
		win = {
			input = {
				keys = {
					["<Esc>"] = { "close", mode = { "n", "i" } },
					["<M-q>"] = { "qflist", mode = { "i", "n" } },
					-- ["<M-q>"] = { "loclist", mode = { "i", "n" } },
					["<C-s>"] = { "edit_split", mode = { "i", "n" } },
					["<C-d>"] = { "edit_vsplit", mode = { "i", "n" } },
				},
			},
		},
		sources = {
			explorer = {
				hidden = true,
				ignored = false,
				layout = {
					preset = "sidebar",
					layout = {
						position = "left",
						width = 32,
						min_width = 32,
					},
				},
				win = {
					input = {
						keys = {
							["<Esc>"] = { "", mode = "n" },
						},
					},
					list = {
						keys = {
							["<Esc>"] = { "", mode = "n" },
						},
					},
				},
			},
			files = {
				hidden = true,
			},
			grep = {
				hidden = true,
				args = { "--hidden", "--glob", "!**/.git/*" },
			},
			buffers = {
				current = false,
				sort_lastused = true,
			},
		},
	},
})
