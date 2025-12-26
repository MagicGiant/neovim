return {
	"quolpr/quicktest.nvim",
	config = function()
		local qt = require("quicktest")

		qt.setup({
			-- Choose your adapter, here all supported adapters are listed
			adapters = {
				require("quicktest.adapters.golang")({}),
			},
			ui = {
				require("quicktest.ui.panel")({
					-- split or popup mode, split is default
					default_win_mode = "split",
					use_builtin_colorizer = true,
				}),
				require("quicktest.ui.diagnostics")(),
				-- open on finishing tests if the quickfix list is not empty
				require("quicktest.ui.quickfix")({ enabled = true, open = false }),
				-- join_to_panel to show with output panel on the same horizontal line,
				-- only_failedto show only failed tests, the stats shows includes passed and skipped tests as well
				require("quicktest.ui.summary")({ join_to_panel = true, only_failed = true, enabled = true }),
			},
		})
	end,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"dennypenta/dashtest.nvim",
	},
	keys = {
		{
			"<leader>tl",
			function()
				local qt = require("quicktest")
				qt.run_line()
				-- You can force open split or popup like this:
				-- qt.run_line('split')
				-- qt.run_line('popup')
			end,
			desc = "[T]est Run [L]line",
		},
		{
			"<leader>td",
			function()
				local qt = require("quicktest")
				-- split output mode (auto), default adapter defined by filetype (auto),
				qt.run_line("auto", "auto", { strategy = "dap" })
			end,
			desc = "[D]ebug [L]line",
		},
		{
			"<leader>ta",
			function()
				local qt = require("quicktest")
				local args_by_ft = {
					go = { "-v", "-failfast", "-race", "short", "-count=1" },
				}
				local args = args_by_ft[vim.bo.ft]
				if not args then
					local msg = string.format("no args for ft=%s found", vim.bo.ft)
					return vim.notify(msg, vim.log.levels.ERROR)
				end

				-- pass additional args to tests
				qt.run_all("auto", "auto", { additional_args = args })
			end,
			desc = "[T]est Run [A]ll",
		},
		{
			"<leader>tf",
			function()
				local qt = require("quicktest")

				qt.run_file()
			end,
			desc = "[T]est Run [F]ile",
		},
		{
			"<leader>td",
			function()
				local qt = require("quicktest")

				qt.run_dir()
			end,
			desc = "[T]est Run [D]ir",
		},
		{
			"<leader>ta",
			function()
				local qt = require("quicktest")

				qt.run_all()
			end,
			desc = "[T]est Run [A]ll",
		},
		{
			"<leader>tp",
			function()
				local qt = require("quicktest")

				qt.run_previous()
			end,
			desc = "[T]est Run [P]revious",
		},
		{
			"<leader>tt",
			function()
				require("quicktest.ui").get("panel").toggle("split")
			end,
			desc = "[T]est [T]oggle Window",
		},
		{
			"<leader>to",
			function()
				require("quicktest.ui").get("panel").toggle("popup")
			end,
			desc = "[T]est [T]oggle Window",
		},
		{
			"<leader>tc",
			function()
				local qt = require("quicktest")
				-- works only for the default strategy, DAP must be stopped using DAP
				qt.cancel_current_run()
			end,
			desc = "[T]est [C]ancel Current Run",
		},
		{
			"]n",
			function()
				local qt = require("quicktest")
				qt.next_failed_test()
			end,
			desc = "Next failed test",
		},
		{
			"[n",
			function()
				local qt = require("quicktest")
				qt.prev_failed_test()
			end,
			desc = "Prev failed test",
		},
		{
			"<leader>ts",
			function()
				-- ui is a registry of all registered ui plugins
				local ui = require("quicktest.ui")
				-- you can get any by a name property defined in the plugin itself,
				-- e.g. summary plugin defines its name property as "summary"
				local summary = ui.get("summary")
				summary.toggle()
			end,
			desc = "[T]est [S]ummary",
		},
		{
			"<leader>tS",
			function()
				require("quicktest.ui").get("summary").toggle_failed_filter()
			end,
			desc = "Toggle summary show only failed",
		},
	},
}
