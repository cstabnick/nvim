return {
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "debugpy" },
				handlers = {},
			})
		end,
	},
	{
		"nvim-neotest/nvim-nio",
	},
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
			-- Uses the debugpy installed by mason
			local debugpy_path = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
			require("dap-python").setup(debugpy_path)
		end,
	},
}
