local function setup_neotest()
    return {
        {
            "nvim-neotest/neotest",
            event = "VeryLazy",
            dependencies = {
                "nvim-neotest/nvim-nio",
                "nvim-lua/plenary.nvim",
                "antoinemadec/FixCursorHold.nvim",
                "nvim-treesitter/nvim-treesitter",
                "nvim-neotest/neotest-plenary",
                "nvim-neotest/neotest-vim-test",
                "Issafalcon/neotest-dotnet",
            },
            opts = function()
                return {
                    adapters = {
                        require('neotest-dotnet')({
                            dap = {
                                args = { justMyCode = false },
                                adaptername = "netcoredbg"
                            },
                            dotnet_additional_args = { "--verbosity detailed" },
                            discovery_root = "project" -- Default
                        })
                    }
                }
            end,
            keys = {
                { "=ta", function() require("neotest").run.attach() end, desc = "[T]est [a]ttach", },
                { "=tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "[T]est run [f]ile", },
                { "=tA", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "[T]est [A]ll files", },
                { "=tS", function() require("neotest").run.run({ suite = true }) end, desc = "[T]est [S]uite", },
                { "=tn", function() require("neotest").run.run() end, desc = "[t]est [n]earest", },
                { "=tl", function() require("neotest").run.run_last() end, desc = "[T]est [l]ast", },
                { "=ts", function() require("neotest").summary.toggle() end, desc = "[T]est [s]ummary", },
                { "=to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "[T]est [o]output", },
                { "=tO", function() require("neotest").output_panel.toggle() end, desc = "[T]est [O]output panel", },
                { "=tt", function() require("neotest").run.stop() end, desc = "[T]est [t]erminate", },
                { "=td", function() require("neotest").run.run({ suite = false, strategy = "dap" }) end, desc = "Debug nearest test", },
            },
        }
    }
end


local function go_dap()
    return {
        'leoluz/nvim-dap-go',
        opts = {
            dap_configurations = {
                {
                    type = 'go',
                    name = 'API Debug',
                    request = 'launch',
                    program = './main.go'
                }
            },
            delve = {
                path = "dlv",
                initialize_timeout_sec = 20,
                port = "${port}",
                args = {},
                build_flags = "",
                detached = true
            },
        }
    }
end

local function python_dap()
    return {
        "mfussenegger/nvim-dap-python",
        config = function()
            require("dap-python").setup("env/bin/python3.12")
        end,
    }
end

local function virtual_text()
    return {
        enabled = true,
        enabeled_commands = true,
        commented = true
    }
end


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
        keys = {
            { "<space>b", "<cmd>DapToggleBreakpoint<CR>",            desc = 'Toggle Breakpoint' },
            { "<space>e", function() require 'dapui'.eval() end,     desc = 'Evaluate Under Cursor' },
            { "<space>u", function() require('dapui').toggle() end,  desc = 'Toggle Ui' },
            { "<space>g", function() require('dap').goto_() end,     desc = 'Go Here' },
            { "<F3>",     function() require('dap').continue() end,  desc = 'Continue' },
            { "<F15>",    function() require('dap').restart() end,   desc = 'Restart' },
            { "<F27>",    function() require('dap').close() end,     desc = 'Stop' },
            { "<F4>",     function() require('dap').step_over() end, desc = 'Step Over' },
            { "<F5>",     function() require('dap').step_into() end, desc = 'Step Into' },
            { "<F17>",    function() require('dap').step_out() end,  desc = 'Step Out' },
        },

        opts = function()
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

            vim.fn.sign_define('DapBreakpoint',
                { text = '󰍒', texthl = 'Title', linehl = 'DapBreakpoint', numhl = 'Title' })
            vim.fn.sign_define('DapStopped',
                { text = '󱋜', texthl = 'Label', linehl = 'Underlined', numhl = 'Label' })
            vim.fn.sign_define('DapBreakpointRejected',
                { text = '󰍑', texthl = 'Macro', linehl = 'DapBreakpointRejected', numhl = 'Macro' })

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
    python_dap(),
    go_dap(),
    setup_neotest()
}
