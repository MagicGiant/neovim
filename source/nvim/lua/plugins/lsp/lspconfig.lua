local function config()
	vim.opt.completeopt = "menu,menuone,noselect"

	-- enable
	vim.lsp.enable("lua_ls", {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})
	-- require('lspconfig').lua_ls.setup({
	-- 	settings = {
	-- 		Lua = {
	-- 			completion = {
	-- 				callSnippet = "Replace"
	-- 			}
	-- 		}
	-- 	},
	-- })

	vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { noremap = true, silent = true })

	vim.lsp.enable("ts_ls", {
		root_markers = { "package-lock.json", "package.json", ".git" },
		settings = {
			typescript = {
				suggest = {
					autoImports = true,
				},
				updateImportsOnFileMove = {
					enabled = "always",
				},
				preferences = {
					includePackageJsonAutoImports = "auto",
					includeCompletionsForImportStatements = true,
				},
				include = {
					"**/*",
				},
			},
			javascript = {
				suggest = {
					autoImports = true,
				},
				updateImportsOnFileMove = {
					enabled = "always",
				},
				include = {
					"**/*",
				},
			},
			implicitProjectConfiguration = {
				checkJs = true,
			},
		},
	})
	vim.lsp.enable("ty")
	vim.lsp.enable("gopls")
	vim.lsp.enable("bashls")
	vim.lsp.enable("html", {
		filetypes = {
			"html",
			"handlebars",
			"ejs",
		},
	})
	vim.lsp.enable("cssls")
	vim.lsp.enable("docker_compose_language_service")

	-- diagnostic
	vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float, { desc = "Show diagnostic" })

	-- rename
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.rename = {
		prepareSupport = true,
	}
end

return {
	"neovim/nvim-lspconfig",
	config = config,
}
