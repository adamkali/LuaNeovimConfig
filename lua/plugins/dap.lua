return {
    {
        "mfussenegger/nvim-dap",
    },
    {
        "rcarriga/nvim-dap-ui",
        keys = {
            { "-uu", ":lua require('dapui').toggle()<CR>", desc = 'Toggle Ui'},
            { "-ue", ":DapToggleBreakpoint<CR>", desc ='Toggle Breakpoint'},
            { "-uo", ":lua require('dap').eval()<CR>", desc ='Evaluate' },

            { "-ss" ,  ":lua require('dap').step_over<CR>", desc ='Step Over' },
            { "-st" ,  ":lua require('dap').step_into<CR>", desc ='Step Into' },
            { "-sn" ,  ":lua require('dap').step_out<CR>", desc ='Step Out' },
            { "-sh" ,  ":lua require('dap').continue<CR>", desc ='Continue' },
            { "-sd" ,  ":lua require('dap').close<CR>", desc ='Stop' }
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
