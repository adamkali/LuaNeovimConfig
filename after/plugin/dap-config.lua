local dap, dapui = require("dap"), require("dapui")
local wk = require('which-key')
--local neotest = require('neotest')

dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

 
vim.fn.sign_define('DapBreakpoint', { text='', texthl='Title', linehl='DapBreakpoint', numhl='Title' })
vim.fn.sign_define('DapStopped', { text='󰙦 ', texthl='IncSearch', linehl='IncSearch', numhl='IncSearch' })

local opts = {
  mode = "n", --      NORMAL mode
  buffer = bufnr, --  Global mappings. Specify a buffer number for buffer local mappings
  silent = true, --   use `silent` when creating keymaps
  noremap = true, --  use `noremap` when creating keymaps
  nowait = false, --  use `nowait` when creating keymaps
  expr = false, --    use `expr` when creating keymaps
}

wk.register({
    ['<leader>u'] = {
        name = 'Debug UI',
        i = { ":lua require('dapui').toggle()<CR>", 'Toggle Ui'},
        u = { ":DapToggleBreakpoint<CR>", 'Toggle Breakpoint'},
        k = { ":lua require('dap').eval()<CR>", 'Evaluate' }, 
    }
}, opts)

wk.register({
    ['<leader>s'] = {
        name = 'Debug Session',
        s = { dap.step_over, 'Step Over' },
        t = { dap.step_into, 'Step Into' },
        n = { dap.step_out, 'Step Out' },
        h = { dap.continue, 'Continue' },
        d = { dap.close, 'Stop' }
    },

}, opts)

vim.g.dotnet_build_project = function()
    local default_path = vim.fn.getcwd() .. '/'
    if vim.g['dotnet_last_proj_path'] ~= nil then
        default_path = vim.g['dotnet_last_proj_path']
    end
    local path = vim.fn.input('Path to your *proj file ', default_path, 'file')
    vim.g['dotnet_last_proj_path'] = path
    local cmd = 'dotnet build -c Debug ' ..  path .. ' > ./build.log 2>&1'
    print('')
    print('Cmd to execute: ' .. cmd)
    local f = os.execute(cmd)
    if f == 0 then
        print('\nBuild: 🤩 ')
    else
        print('\nBuild: 🥺 (code: ' .. f .. ')')
    end
end

vim.g.dotnet_get_dll_path = function()
    local request = function()
        return vim.fn.input('Specify the DLL File: ', vim.fn.getcwd() .. '\\bin\\Debug\\net6.0\\', 'file')
    end

    if vim.g['dotnet_last_dll_path'] == nil then
        vim.g['dotnet_last_dll_path'] = request()
    else
        if vim.fn.confirm('Do you want to change the path to dll? ' .. vim.g['dotnet_last_dll_path'], '&yes\n&no', 2) == 1 then
            vim.g['dotnet_last_dll_path'] = request()
        end
    end

    return vim.g['dotnet_last_dll_path']
end

vim.g.dotnet_proj_telescope_select = function()
    -- assert that rg is installed
    local rg = vim.fn.executable('rg')
    if rg == 0 then
        print('rg is not installed')
        return
    end
    -- ripgrep -g *.csproj
    local cmd = 'rg -g *.csproj'
    local f = io.popen(cmd)
    local result = {}
    for line in f:lines() do
        table.insert(result, line)
    end
    f:close()

    local picker = require('telescope.pickers')
    local finders = require('telescope.finders')
    local sorters = require('telescope.sorters')
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')

    picker.new({}, {
        prompt_title = 'dotnet projects',
        finder = finders.new_table {
            results = result,
            entry_maker = function(line)
                return {
                    value = line,
                    display = line,
                    ordinal = line,
                }
            end
        },
        sorter = sorters.get_generic_fuzzy_sorter(),
        attach_mappings = function(prompt_bufnr, map)
            map('i', '<CR>', function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                vim.g['dotnet_last_proj_path'] = selection.value
                vim.g.dotnet_build_project()
            end)
            return true
        end
    }):find()
end


-- used by nvim-dap
--
dap.adapters.coreclr = {
	type = 'executable',
	command =  'netcoredbg',
	args = { '--interpreter=vscode' },
}

local path_to_csharp_test = ""
local test_name = ""
dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function()
            if vim.fn.confirm('Should I recompile first?', '&yes\n&no', 2) == 1 then
                vim.g.dotnet_build_project()
            end
            return vim.g.dotnet_get_dll_path()
        end,
        env = {
          ASPNETCORE_ENVIRONMENT = "Development", -- Adjust this to the desired environment
        },
    },
}

-- go C:\Users\adam\AppData\Local\vscode-go\dist
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

dapui.setup{
    controls = {
        element = "repl",
        enabled = true,
        icons = {
            disconnect = "",
            pause = "",
            play = "",
            run_last = "",
            step_back = "",
            step_into = "",
            step_out = "",
            step_over = "",
            terminate = ""
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
        position = "bottom",
        size = 10
    } },
}

--    layouts = { {
--        elements = { {
--            id = "scopes",
--            size = 0.25
--          }, {
--            id = "breakpoints",
--            size = 0.25
--          }, {
--            id = "stacks",
--            size = 0.25
--          }, {
--            id = "watches",
--            size = 0.25
--          } },
--        position = "left",
--        size = 40
--      }, {
--        elements = { {
--            id = "repl",
--            size = 0.5
--          }, {
--            id = "console",
--            size = 0.5
--          } },
--        position = "bottom",
--        size = 10
--      } },
--    mappings = {
--      edit = "e",
--      expand = { "<CR>", "<2-LeftMouse>" },
--      open = "o",
--      remove = "d",
--      repl = "r",
--      toggle = "t"
--    },
--    render = {
--      indent = 1,
--      max_value_lines = 100
--    }
--  }
