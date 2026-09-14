vim.pack.add({
	"https://github.com/folke/noice.nvim",
	"https://github.com/MunifTanjim/nui.nvim", -- Required UI component library
	"https://github.com/rcarriga/nvim-notify", -- Required for notifications
})

require("noice").setup({
	cmdline = {
		enabled = true,
		view = "cmdline_popup", -- Changes the default 'cmdline_popup' to the classic bottom view
	},
	messages = { enabled = true },
	views = {
		hover = {
			border = {
				style = "rounded",
				padding = { 1, 2 }, -- 1 line top/bottom, 2 spaces left/right
			},
		},
		confirm = {
			format = { "{message}" }, -- show the question text, then the Yes/No buttons
		},

		notify = {
			timeout = 1 * 1000,
		},
		-- For the mini view (bottom-right notifications)
		mini = {
			timeout = 1 * 1000,
		},
		-- For the popup view (centered floating windows)
		popup = {
			timeout = 2 * 1000,
		},
		-- For cmdline_popup (fancy command line)
		cmdline_popup = {
			timeout = 3 * 1000,
		},
	},
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
		hover = { enabled = false }, -- false to use native instead
		signature = { enabled = false }, -- disabled to avoid conflict with blink
	},
	presets = {
		bottom_search = false,
		command_palette = true,
		long_message_to_split = true,
		lsp_doc_border = true, -- Enables the border around hover/signature
	},
})
