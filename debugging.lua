return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "nvim-telescope/telescope-dap.nvim", -- Optional
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dapui.setup()

        dap.adapters.python = function(cb, config)
            if config.request == "attach" then
                local port = (config.connect or config).port
                local host = (config.connect or config).host or "127.0.0.1"
                cb({
                    type = "server",
                    port = assert(port, "`connect.port` is required for a python `attach` configuration"),
                    host = host,
                    options = {
                        source_filetype = "python",
                    },
                })
            else
                cb({
                    type = "executable",
                    command = os.getenv("VIRTUAL_ENV") .. "/bin/python", -- Ensure this path points to your virtualenv's python
                    args = { "-m", "debugpy.adapter" },
                    options = {
                        source_filetype = "python",
                    },
                })
            end
        end

        dap.configurations.python = {
            {
                type = "python", -- This links to the adapter definition
                request = "launch",
                name = "Launch file",

                program = "${file}", -- This launches the current file if used.
                pythonPath = function()
                    local cwd = vim.fn.getcwd()
                    if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
                        return cwd .. "/venv/bin/python"
                    elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
                        return cwd .. "/.venv/bin/python"
                    else
                        return "/usr/bin/python"
                    end
                end,
            },
        }

        dap.adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
                command = "node",
                args = { "/home/vxser/js-debug-dap-1.94.0/src/dapDebugServer.js", "${port}" }, -- Update this path
            },
        }

        -- Add configuration for JavaScript
        dap.configurations.javascript = {
            {
                type = "pwa-node",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                cwd = "${workspaceFolder}",
            },
        }

        -- Set up codelldb adapter
        dap.adapters.lldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = "/home/vxser/codelldb/extension/adapter/codelldb", -- Update with your path
                args = { "--port", "${port}" },
            },
        }

        -- DAP configurations for C, C++, and Rust
        dap.configurations.cpp = {
            {
                name = "Launch file",
                type = "lldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
            },
        }

        dap.configurations.c = dap.configurations.cpp
        dap.configurations.rust = dap.configurations.cpp

        -- Auto open/close dap-ui
        dap.listeners.before.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        -- Keybindings for DAP
        vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
        vim.keymap.set("n", "<Leader>dc", dap.continue, {})
        vim.keymap.set("n", "<Leader>di", dap.step_into, {})
        vim.keymap.set("n", "<Leader>do", dap.step_over, {})
        vim.keymap.set("n", "<Leader>dr", dap.repl.open, {})
    end,
}
