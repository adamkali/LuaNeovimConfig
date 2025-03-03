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
                "nvim-neotest/neotest-python",
                "Issafalcon/neotest-dotnet",
                {
                    "fredrikaverpil/neotest-golang", -- Installation
                    dependencies = {
                        "leoluz/nvim-dap-go",
                    },
                },
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
                        }),
                        require("neotest-python")({
                            python = ".env/bin/python"
                        }),
                        require("rustaceanvim.neotest"),
                        require("neotest-golang")
                    }
                }
            end,
            keys = {
                { "=ta", function() require("neotest").run.attach() end,                                     desc = "Test attach", },
                { "=tf", function() require("neotest").run.run(vim.fn.expand("%")) end,                      desc = "Test run file", },
                { "=tA", function() require("neotest").run.run(vim.uv.cwd()) end,                            desc = "Test All files", },
                { "=tS", function() require("neotest").run.run({ suite = true }) end,                        desc = "Test Suite", },
                { "=tn", function() require("neotest").run.run() end,                                        desc = "Test Nearest", },
                { "=tl", function() require("neotest").run.run_last() end,                                   desc = "Test last", },
                { "=ts", function() require("neotest").summary.toggle() end,                                 desc = "Test summary", },
                { "=to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Test output", },
                { "=tO", function() require("neotest").output_panel.toggle() end,                            desc = "Test output panel", },
                { "=tt", function() require("neotest").run.stop() end,                                       desc = "Test terminate", },
                { "=td", function() require("neotest").run.run({ suite = false, strategy = "dap" }) end,     desc = "Debug nearest test", },
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
    setup_neotest()
}
