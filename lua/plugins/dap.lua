local function python_dap()
    return {
        "mfussenegger/nvim-dap-python",
        config = function()
            require("dap-python").setup("/usr/bin/python3")
        end,
    }
end

local function venv_selector()
    return {
        'linux-cultist/venv-selector.nvim',
        dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
        opts = {},
        event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
        keys = {
            { '<leader>hv', '<cmd>VenvSelect<cr>' },
            { '<leader>hV', '<cmd>VenvSelectCached<cr>' },
        },
    }
end

return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
        },
        keys = {
            { "<space>b", "<cmd>DapToggleBreakpoint<CR>",            desc = 'Toggle Breakpoint' },
            { "<space>e", function() require 'dap'.eval() end,       desc = 'Evaluate Under Cursor' },
            { "<space>u", function() require('dapui').toggle() end,  desc = 'Toggle Ui' },
            { "<F3>",     function() require('dap').continue() end,  desc = 'Continue' },
            { "<F15>",    function() require('dap').restart() end,   desc = 'Restart' },
            { "<F27>",    function() require('dap').close() end,     desc = 'Stop' },
            { "<F4>",     function() require('dap').step_over() end, desc = 'Step Over' },
            { "<F16>",    function() require('dap').goto_() end,     desc = 'Go Here' },
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
                    size = 50
                } },
            }
        end,
    },
    venv_selector(),
    python_dap(),
    {
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
    },
}
