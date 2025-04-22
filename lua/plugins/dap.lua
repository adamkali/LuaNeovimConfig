-- Set up ui options

vim.fn.sign_define('DapBreakpoint',
    { text = '󰒲', texthl = 'Title', linehl = 'DapBreakpoint', numhl = 'Title' })
vim.fn.sign_define('DapStopped',
    { text = '󰞏', texthl = 'Label', linehl = 'Function', numhl = 'Function' })
vim.fn.sign_define('DapBreakpointRejected',
    { text = '󱜞', texthl = 'Macro', linehl = 'DapBreakpointRejected', numhl = 'DapBreakpoint' })

-- Python Debug setup

local function python_dap()
    return {
        "mfussenegger/nvim-dap-python",
        config = function()
            require("dap-python").setup("env/bin/python3")
        end,
    }
end

-- Golang Debug setup [nvim-dap-go]{https://github.com/leoluz/nvim-dap-go}

local function golang_dap()
    return { "leoluz/nvim-dap-go" }
end

-- Virtual Text to show what what they values are during debugging

local function virtual_text()
    return {
        enabled = true,
        enabeled_commands = true,
        commented = true
    }
end

-- The Plugin Table for dap.lua

return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
            {
                "theHamsta/nvim-dap-virtual-text",
                opts = virtual_text()
            }
        },

-- Options Table for nvim-dap-ui

        opts = function()
            local dap = require "dap"
            local dapui = require "dapui"

-- To set up auto open

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

-- Finally we create the returning options table

           return {
                controls = {
                    element = "repl",
                    enabled = true,
                    icons = {
                        disconnect = "",
                        pause = "",
                        play = "",
                        terminate = ""
                    }
                },
                mappings = {
                    toggle = "l"
                },
                layouts = { {
                    elements = { {
                        id = "scopes",
                        size = 0.33
                    }, {
                        id = "breakpoints",
                        size = 0.33
                    }, {
                        id = "repl",
                        size = 0.33
                    } },
                    position = "right",
                    size = 60
                } },
            }
        end,
    },
    { "leoluz/nvim-dap-go", opts = {} },
    python_dap(),
}
