return {
    {
    "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    -- Telescope configuration
    require('telescope').setup({
      defaults = {
        file_ignore_patterns = { "node_modules", ".git", "vendor", "build", "dist" },
        vimgrep_arguments = {
          'rg',
          '--hidden', -- search hidden files
          '--column',
          '--line-number',
          '--no-heading',
          '--with-filename',
          '--color=never',
          '--smart-case',
        }
      }
    })
       vim.api.nvim_set_keymap('n', '<leader>fg', ':lua require("telescope.builtin").live_grep({ cwd = vim.fn.expand("%:p:h") })<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope find_files cwd=%:p:h<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>fh', ':Telescope command_history<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<leader>fc', ':lua require("telescope.builtin").command_history()<CR>', { noremap = true, silent = true })

  end
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
             require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown {
                }
            }
        }
    })
        require("telescope").load_extension("ui-select")
    end
    },
}
