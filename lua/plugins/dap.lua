return {
	{ "nvim-neotest/nvim-nio" },
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dapui = require("dapui")
			dapui.setup()

			local dap = require("dap")
			-- Open/close dapui automatically when debugging starts/ends
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")

			-- Keymaps
			vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP: Toggle breakpoint" })
			vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP: Continue" })
			vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "DAP: Step over" })
			vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP: Step into" })
			vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "DAP: Step out" })
			vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "DAP: Terminate session" })
			vim.keymap.set("n", "<leader>du", function()
				require("dapui").toggle()
			end, { desc = "DAP: Toggle UI" })
			vim.keymap.set("n", "<leader>dB", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "DAP: Set conditional breakpoint" })
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		dependencies = { "mfussenegger/nvim-dap" },
		ft = "python",
		config = function()
			-- Find a Python interpreter that has debugpy installed.
			--
			-- Resolution order:
			--   1. A .venv in the current working directory (project-local uv venv)
			--   2. The uv tool venv for debugpy (global fallback)
			--      Install with: uv tool install debugpy
			local function find_python()
				-- 1. Project-local .venv (standard uv project layout)
				local cwd_venv = vim.fn.getcwd() .. "/.venv/bin/python"
				if vim.fn.executable(cwd_venv) == 1 then
					return cwd_venv
				end

				-- 2. uv tool install debugpy
				local uv_tool_python = vim.fn.expand("~/.local/share/uv/tools/debugpy/bin/python")
				if vim.fn.executable(uv_tool_python) == 1 then
					return uv_tool_python
				end

				vim.notify(
					"nvim-dap-python: no Python with debugpy found.\nRun: uv tool install debugpy",
					vim.log.levels.ERROR
				)
				return nil
			end

			local python = find_python()
			if python then
				require("dap-python").setup(python)
			end
		end,
	},
}
