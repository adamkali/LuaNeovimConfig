return {
    {
        "mfussenegger/nvim-dap",
    },
    {
        "rcarriga/nvim-dap-ui",
        keys = {
            { "-uu", ":lua require('dapui').toggle()<CR>", 'Toggle Ui'},
            { "-ue", ":DapToggleBreakpoint<CR>", 'Toggle Breakpoint'},
            { "-uo", ":lua require('dap').eval()<CR>", 'Evaluate' },

            { "-ss" ,  ":lua require('dap').step_over<CR>", 'Step Over' },
            { "-st" ,  ":lua require('dap').step_into<CR>", 'Step Into' },
            { "-sn" ,  ":lua require('dap').step_out<CR>", 'Step Out' },
            { "-sh" ,  ":lua require('dap').continue<CR>", 'Continue' },
            { "-sd" ,  ":lua require('dap').close<CR>", 'Stop' }
        },
        config = function ()
            local dap = require"dap"
            local dapui = require"dapui"

            dap.listeners.after.event_initialized["dapui_config"] = function()
              dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
              dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
              dapui.close()
            end

            vim.fn.sign_define('DapBreakpoint', { text='󱠡 ', texthl='Title', linehl='DapBreakpoint', numhl='Title' })
            vim.fn.sign_define('DapStopped', { text='󰙦', texthl='Delimiter', linehl='Underlined', numhl='Underlined' })

            dap.adapters.go = {
                type = 'executable',
                command = 'node',
                args = { os.getenv('LOCALAPPDATA') .. '/vscode-go/dist/debugAdapter.js' },
            }
            dap.configurations.go = {
                {
                    type = 'go',
                    name = 'Debug',
                    request = 'launch',
                    program = vim.fn.getcwd() .. '/main.go',
                    dlvToolPath = vim.fn.exepath('dlv') -- Adjust to where delve is installed
                }
            }

        end,
        opts = {
            controls = {
                element = "repl",
                enabled = true,
                icons = {
                    disconnect = "",
                    pause = "",
                    play = "",
                    run_last = "󰦛 ",
                    step_back = "󱞧 ",
                    step_into = "󱞣 ",
                    step_out = "󱞿 ",
                    step_over = "",
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
    }
}
