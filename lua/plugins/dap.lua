return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
        },
        keys = {
            { "-uu",  "<cmd>DapToggleBreakpoint<CR>",           desc = 'Toggle Breakpoint' },
            { "-ui",  function () require('dapui').open() end, desc = 'Toggle Ui'},
            { "-ue",  function () require('dap').eval() end,     desc = 'Evaluate' },
            { "-sh",  function () require('dap').step_over() end,  desc = 'Step Over' },
            { "-st",  function () require('dap').step_into() end,  desc = 'Step Into' },
            { "-sn",  function () require('dap').step_out() end,   desc = 'Step Out' },
            { "-ss",  function () require('dap').continue() end,   desc = 'Continue' },
            { "-sd",  function () require('dap').close() end,      desc = 'Stop' }
        },
        config = function()
            local dap = require "dap"
            local dapui = require "dapui"

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            vim.fn.sign_define('DapBreakpoint', { text = '󱠡', texthl = 'Title', linehl = 'DapBreakpoint', numhl = 'Title' })
            vim.fn.sign_define('DapStopped', { text = '', texthl = 'Delimiter', linehl = 'Underlined', numhl = 'Underlined' })
        end,
        opts = {
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
                toggle = "g"
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
                size = 40
            } },
        }
    },
    {
        'leoluz/nvim-dap-go',
        opts = {
            dap_configurations = {
                {
                    type = "go",
                    name = "Attach remote",
                    mode = "remote",
                    request = "attach",
                },
            },
            delve = {
                path = "dlv",
                initialize_timeout_sec = 20,
                port = "${port}",
                -- additional args to pass to dlv
                args = {},
                -- the build flags that are passed to delve.
                -- defaults to empty string, but can be used to provide flags
                -- such as "-tags=unit" to make sure the test suite is
                -- compiled during debugging, for example.
                -- passing build flags using args is ineffective, as those are
                -- ignored by delve in dap mode.
                build_flags = "",
                detached = true
            },
        }
    }
}
