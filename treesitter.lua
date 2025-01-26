return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = { "c", "lua", "python", "javascript", "html", "css","scheme","racket" }, -- Include C and other languages as needed
            highlight = {
                enable = true, -- Enable highlighting
                additional_vim_regex_highlighting = false, -- Disable additional regex highlighting
            },
            auto_install = {
                enable = true,
            },
            indent = {
                enable = true, -- Enable indentation
            },
            autopairs = {
                enable = true, -- Enable autopairs
            },
            -- Add other configurations as needed
        }

    end
}

