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

vim.g.dotnet_get_appsettings = function()
    local default_path = vim.fn.getcwd() .. '\\'
    if vim.g['dotnet_last_appsettings_path'] ~= nil then
        default_path = vim.g['dotnet_last_appsettings_path']
    end
    local path = vim.fn.input('Path to your appsettings.json file ', default_path, 'file')
    vim.g['dotnet_last_appsettings_path'] = path
    return path
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

-- use dotnet run -c Debug --project <path to project> to run the project
-- and then attach to the process
vim.g.run_dotnet_project = function()
    local default_path = vim.fn.getcwd() .. '/'
    if vim.g['dotnet_last_proj_path'] ~= nil then
        default_path = vim.g['dotnet_last_proj_path']
    end
    local path = vim.fn.input('Path to your *proj file ', default_path, 'file')
    vim.g['dotnet_last_proj_path'] = path
    local cmd = 'dotnet run -c Debug --project ' ..  path .. ' > ./run.log 2>&1'
    print('')
    print('Cmd to execute: ' .. cmd)
    local f = os.execute(cmd)
    if f == 0 then
        print('\nRun: 🤩 ')
    else
        print('\nRun: 🥺 (code: ' .. f .. ')')
    end
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
          vim.g.dotnet_get_appsettings()
          return vim.g.dotnet_get_dll_path()
      end,
      args = {},  -- Add additional command-line arguments here
      cwd = vim.fn.getcwd(),  -- Set the working directory to the current project directory
      stopOnEntry = false,
      serverReadyAction = {
          action = "openExternally",
          pattern = "\\bNow listening on:\\s+(https?://\\S+)"
      },
      setup = {
          configuration = vim.g['dotnet_last_proj_path']
      },
      preLaunchTask = "build",
      logging = {
          level = "verbose",
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
            play = "",
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

