---@diagnostic disable: undefined-global
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		{ "williamboman/mason-lspconfig.nvim" },
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
	},

	config = function()
		local lspconfig = require("lspconfig")
		local cmp_lsp = require("cmp_nvim_lsp")
		local mlsp = require("mason-lspconfig")
		local capabilities = cmp_lsp.default_capabilities()
		local km = vim.keymap

		-- format on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = { "*.go", "*.c", "*.cpp", "*.h", "*.hpp" },
			callback = function()
				vim.lsp.buf.format({ async = false })
			end,
		})

		-- diagnostic icons
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
				},
			},
		})

		-- LSP-specific keymaps
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local o = { buffer = ev.buf, silent = true }
				km.set("n", "gR", "<cmd>Telescope lsp_references<CR>", vim.tbl_extend("force", o, { desc = "Refs" }))
				km.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", o, { desc = "Decl" }))
				km.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", vim.tbl_extend("force", o, { desc = "Defs" }))
				km.set(
					"n",
					"gi",
					"<cmd>Telescope lsp_implementations<CR>",
					vim.tbl_extend("force", o, { desc = "Impls" })
				)
				km.set(
					"n",
					"gt",
					"<cmd>Telescope lsp_type_definitions<CR>",
					vim.tbl_extend("force", o, { desc = "Types" })
				)
				km.set(
					{ "n", "v" },
					"<leader>ca",
					vim.lsp.buf.code_action,
					vim.tbl_extend("force", o, { desc = "Actions" })
				)
				km.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", o, { desc = "Rename" }))
				km.set(
					"n",
					"<leader>D",
					"<cmd>Telescope diagnostics bufnr=0<CR>",
					vim.tbl_extend("force", o, { desc = "Diag buf" })
				)
				km.set("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", o, { desc = "Diag line" }))
				km.set("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", o, { desc = "Prev diag" }))
				km.set("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", o, { desc = "Next diag" }))
				km.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", o, { desc = "Hover" }))
				km.set("n", "<leader>rs", ":LspRestart<CR>", vim.tbl_extend("force", o, { desc = "Restart" }))
			end,
		})

		-- mason-lspconfig v2: one call, handlers table
		mlsp.setup({
			handlers = {
				-- default handler
				function(server)
					lspconfig[server].setup({ capabilities = capabilities })
				end,

				-- custom servers / overrides ----------
				svelte = function()
					lspconfig.svelte.setup({
						capabilities = capabilities,
						on_attach = function(client)
							vim.api.nvim_create_autocmd("BufWritePost", {
								pattern = { "*.js", "*.ts" },
								callback = function(ctx)
									if client and client.notify and client.name == "svelte" then
										client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
									end
								end,
							})
						end,
					})
				end,

				graphql = function()
					lspconfig.graphql.setup({
						capabilities = capabilities,
						filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
					})
				end,

				emmet_ls = function()
					lspconfig.emmet_ls.setup({
						capabilities = capabilities,
						filetypes = {
							"html",
							"typescriptreact",
							"javascriptreact",
							"css",
							"sass",
							"scss",
							"less",
							"svelte",
						},
					})
				end,

				lua_ls = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = { globals = { "vim" } },
								completion = { callSnippet = "Replace" },
							},
						},
					})
				end,

				gopls = function()
					lspconfig.gopls.setup({
						-- on_attach = function(client, bufnr)
						-- 	require("lsp_signature").on_attach(signature_setup, bufnr) -- Note: add in lsp client on-attach
						-- end,
						capabilities = capabilities,
						settings = {
							gopls = {
								analyses = { unusedparams = true, shadow = true },
								staticcheck = true,
							},
						},
					})
				end,

				clangd = function()
					lspconfig.clangd.setup({
						capabilities = capabilities,
						cmd = { "clangd", "--background-index", "--clang-tidy" },
						filetypes = { "c", "cpp", "objc", "objcpp" },
						root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
					})
				end,
			},
		})
	end,
}
