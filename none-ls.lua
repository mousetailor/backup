return {
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")

            -- Define sources for formatting and diagnostics
            local sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.clang_format,
                null_ls.builtins.formatting.prettier,
               -- null_ls.builtins.diagnostics.eslint_d,  -- Switch back to eslint if needed
               -- null_ls.builtins.diagnostics.clangd,   -- Ensure clangd is available
                null_ls.builtins.formatting.black,
                null_ls.builtins.formatting.isort,
            }

            -- Setup null-ls
            null_ls.setup({
                sources = sources,
                on_attach = function(client)
                    -- Ensure the client has the required capabilities
                    if client and client.server_capabilities.document_formatting then
                        vim.api.nvim_command("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
                    end
                end,
            })

            -- Key mapping for formatting
            vim.keymap.set("n", "<leader>gf", function()
                vim.lsp.buf.format({ async = true })
            end, { noremap = true, silent = true })
        end,
    },
}

