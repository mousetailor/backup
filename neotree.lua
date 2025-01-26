return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            filesystem = {
                use_libuv_file_watcher = true,
                filtered_items = {
                    hide_dotfiles = true,   -- Set to true if you want to hide all dotfiles
                    hide_gitignored = true, -- Keep hiding gitignored files
                    custom = { ".luarc.json" }, -- Specifically hide .luarc.json
                },
                follow_current_file = true, -- Automatically focus the current file
                hijack_netrw_behavior = "open_default", -- Open files with default behavior
            },
            window = {
                position = "left",
                width = 30,
            },
        })

        -- Key mapping to toggle Neo-tree
        vim.api.nvim_set_keymap("n", "<leader>n", ":Neotree toggle<CR>", { noremap = true, silent = true })
    end,
}
