-- 1. Native installation
vim.pack.add({ "https://github.com/echasnovski/mini.hipatterns" })

-- 2. Clean, minimal setup
local hipatterns = require("mini.hipatterns")

hipatterns.setup({
	highlighters = {
		-- ()%s*%f[%w] captures optional leading spaces AND the keyword while avoiding false matches like "MYTODO"

		-- --- TODO ---
		todo_label = { pattern = "()%s*%f[%w]TODO:?()", group = "MiniHipatternsTodo" },
		todo_text = { pattern = "%f[%w]TODO:?%s+().*()", group = "DiagnosticInfo" },

		-- --- WARN ---
		warn_label = { pattern = "()%s*%f[%w]WARN:?()", group = "MiniHipatternsHack" },
		warn_text = { pattern = "%f[%w]WARN:?%s+().*()", group = "DiagnosticWarn" },

		-- --- FIXME ---
		fixme_label = { pattern = "()%s*%f[%w]FIXME:?()", group = "MiniHipatternsFixme" },
		fixme_text = { pattern = "%f[%w]FIXME:?%s+().*()", group = "DiagnosticError" },

		-- --- NOTE ---
		note_label = { pattern = "()%s*%f[%w]NOTE:?()", group = "MiniHipatternsNote" },
		note_text = { pattern = "%f[%w]NOTE:?%s+().*()", group = "DiagnosticHint" },
	},
	delay = {
		text_change = 0, -- Instantaneous
		scroll = 0,
	},
})
