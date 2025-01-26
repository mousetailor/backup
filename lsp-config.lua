return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "ts_ls", "clangd"},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")

			-- Lua Language Server
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
      

      lspconfig.clojure_lsp.setup {}


			-- TypeScript Language Server
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				on_attach = function(client)
					client.server_capabilities.document_formatting = false -- Prevent formatting conflicts
				end,
			})

			-- C/C++ Language Server
             lspconfig.clangd.setup {
    cmd = { "clangd", "--compile-commands-dir=build", "--header-insertion=always" },
    root_dir = function() return vim.loop.cwd() end,
    on_attach = function(client)
        -- Optional: Add any additional on-attach configurations here
    end,
    settings = {
        clangd = {
            compilationDatabasePath = "build",
            logLevel = "error", -- or "warning", "info", "debug"
            filetypes = { "c", "cpp" },
            includePath = {
                "/usr/include/gtk-3.0",
                "/usr/include/gio-unix-2.0",
                "/usr/include/cairo",
                "/usr/include/pango-1.0",
                "/usr/include/glib-2.0",
                -- Add any other include paths as necessary
            },
        },
    },
}           

            lspconfig.eslint_d.setup({
                capabilities = capabilities,
            })
            

			-- Key mappings
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
