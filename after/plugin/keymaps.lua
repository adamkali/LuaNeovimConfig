local wk = require('which-key').add
wk {
    { "<space>c", expr = false, group = "Quickfix", nowait = false, remap = false, icon = { icon = "󰓅", hl = "Function" } },
    { "<space>ca", function() vim.cmd [[cprev]] end, desc = 'Quickfix Prev', expr = false, nowait = false, remap = false },
    { "<space>cc", function() vim.cmd [[cclose]] end, desc = 'Quickfix Close', expr = false, nowait = false, remap = false },
    { "<space>co", function() vim.cmd [[copen]] end, desc = 'Quickfix Open List', expr = false, nowait = false, remap = false },
    { "<space>cs", function() vim.cmd [[cnext]] end, desc = 'Quickfix Next', expr = false, nowait = false, remap = false },
}

local telescope_leader = "<leader>h"
wk {
    { telescope_leader,        group = "Telescope",                                nowait = false,            remap = false },
    { telescope_leader .. "h", "<cmd>Telescope find_files<cr>",                    desc = "Find Files",       expr = false, nowait = false, remap = false },
    { telescope_leader .. "H", "<cmd>Telescope help_tags<cr>",                     desc = "Find Help Tags",   expr = false, nowait = false, remap = false },
    { telescope_leader .. "g", "<cmd>Telescope live_grep<cr>",                     desc = "Find Grep",        expr = false, nowait = false, remap = false },
    { telescope_leader .. "c", "<cmd>Telescope commands<cr>",                      desc = "Find Commands",    expr = false, nowait = false, remap = false },
    { telescope_leader .. "b", "<cmd>Telescope buffers<cr>",                       desc = "Find Buffers",     expr = false, nowait = false, remap = false },
    { telescope_leader .. "m", "<cmd>Telescope marks<cr>",                         desc = "Find Marks",       expr = false, nowait = false, remap = false },
    { telescope_leader .. "y", "<cmd>Telescope registers<cr>",                     desc = "Find Registers",   expr = false, nowait = false, remap = false },
    { telescope_leader .. "d", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Find Symbols",     expr = false, nowait = false, remap = false },
    { telescope_leader .. "D", "<cmd>Telescope diagnostics<cr>",                   desc = "Find Diagnostics", expr = false, nowait = false, remap = false },
    { telescope_leader .. "r", "<cmd>Telescope lsp_refrences<cr>",                 desc = "Find Refrences",   expr = false, nowait = false, remap = false },
    { telescope_leader .. "n", "<cmd>Telescope nerdy<cr>",                         desc = "Find Icons",       expr = false, nowait = false, remap = false },
    { telescope_leader .. "t", "<cmd>Telescope <cr>",                              desc = "Telescope",        expr = false, nowait = false, remap = false },
}
local debug_leader = "<space>d"
local debug_move = "s"
local debug_ui = "u"

wk {
    { debug_leader, expr = false, group = "Debug", nowait = false, remap = false, icon = { icon = "", hl = "@constructor.tsx" } },
    { debug_leader .. debug_ui .."b", "<cmd>DapToggleBreakpoint<CR>", desc = 'Toggle Breakpoint' },
    { debug_leader .. debug_ui .."e", function() require 'dapui'.eval() end, desc = 'Evaluate Under Cursor' },
    { debug_leader .. debug_ui .."u", function() require('dapui').toggle() end, desc = 'Toggle Ui' },
    { debug_leader .. debug_move, expr = false, group = "Debug Movements", nowait = false, remap = false, icon = { icon = "", hl = "@function.method" } },
    { debug_leader .. debug_move .. "g", function() require('dap').goto_() end, desc = 'Go Here' },
    { debug_leader .. debug_move .. "c", function() require('dap').continue() end, desc = 'Continue' },
    { debug_leader .. debug_move .. "r", function() require('dap').restart() end, desc = 'Restart' },
    { debug_leader .. debug_move .. "s", function() require('dap').step_over() end, desc = 'Step Over' },
    { debug_leader .. debug_move .. "t", function() require('dap').step_into() end, desc = 'Step Into' },
    { debug_leader .. debug_move .. "n", function() require('dap').step_out() end, desc = 'Step Out' },
}

local dotnet_leader= "<leader>d"
wk {
    { dotnet_leader, expr = false, group = "Debug", nowait = false, remap = false, icon = { icon = "", hl = "Function" } },
    { '<leader>ds', function() require('dotnvim').bootstrap() end,  desc = 'Bootstrap Class' },
    { '<leader>db', function() require('dotnvim').build(false) end, desc = 'Build Last Project' },
    { '<leader>dw', function() require('dotnvim').watch(true) end,  desc = 'Watch Last Project' },
}

wk {
    { "<space>f",     expr = false,                                       group = "[f]inder",          nowait = false, remap = false },
    { "<space>ff",    "<cmd>Telescope find_files<cr>",                    desc = "[f]iles" },
    { "<space>fh",    "<cmd>Telescope help_tags<cr>",                     desc = "[t]ags" },
    { "<space>fg",    "<cmd>Telescope live_grep<cr>",                     desc = "[g]rep" },
    { "<space>fc",    "<cmd>Telescope commands<cr>",                      desc = "[c]ommands" },
    { "<space>fb",    "<cmd>Telescope buffers<cr>",                       desc = "[b]uffers" },
    { "<space>fm",    "<cmd>Telescope marks<cr>",                         desc = "[m]arks" },
    { "<space>fy",    "<cmd>Telescope registers<cr>",                     desc = "[r]egisters" },
    { "<space>fls",   "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "[l]sp [s]ymbols" },
    { "<space>fld",   "<cmd>Telescope diagnostics<cr>",                   desc = "[l]sp [d]iagnostics" },
    { "<space>flr",   "<cmd>Telescope lsp_refrences<cr>",                 desc = "[l]sp [r]efrences" },
    { "<space>fn",    "<cmd>Telescope nerdy<cr>",                         desc = "[N]erdfonts " },
    { "<space>fk",    "<cmd>Telescope keymaps<cr>",                       desc = "[k]eymaps" },
    { "<space><C-f>", "<cmd>Telescope <cr>",                              desc = "Telescope Control" },
}

wk {
    { "<space>d",     expr = false,                              group = "[d]ebuger",             nowait = false, remap = false },
    { "<space>db",    "<cmd>DapToggleBreakpoint<CR>",            desc = 'Toggle [b]reakpoint' },
    { "<space>de",    function() require 'dapui'.eval() end,     desc = '[e]valuate Under Cursor' },
    { "<space>du",    function() require('dapui').toggle() end,  desc = 'Toggle [u]i' },
    { "<space>dg",    function() require('dap').goto_() end,     desc = '[g]o Here' },
    { "<space>d<F6>", function() require('dap').stop() end,      desc = 'Stop' },
    { "<space>d<F5>", function() require('dap').restart() end,   desc = 'Restart' },
    { "<F5>",         function() require('dap').continue() end,  desc = 'Continue' },
    { "<F10>",        function() require('dap').step_over() end, desc = 'Step Over' },
    { "<F11>",        function() require('dap').step_into() end, desc = 'Step Into' },
    { "<F12>",        function() require('dap').step_out() end,  desc = 'Step Out' },
}

wk {
    { "<space><c-d>",  expr = false,                                   group = "[d]otnet ",          nowait = false, remap = false },
    { '<space><c-d>s', function() require('dotnvim').bootstrap() end,  desc = 'Boot[s]trap Class' },
    { '<space><c-d>b', function() require('dotnvim').build(false) end, desc = '[b]uild Last Project' },
}

wk {
    { "<c-o>",      expr = false,                          group = "[o]bsidian",         nowait = false, remap = false },
    { '<c-o>v',     '<cmd>:ObsidianFollowLink vsplit<CR>', desc = 'Split [v]ertically' },
    { '<c-o>h',     '<cmd>:ObsidianFollowLink hsplit<CR>', desc = 'Split [h]orizontally' },
    { '<c-o>b',     '<cmd>:ObsidianBacklinks<CR>',         desc = 'Show [b]ack Links' },
    { '<c-o>t',     '<cmd>:ObsidianToday<CR>',             desc = 'Open [t]oday' },
    { '<c-o>p',     '<cmd>:ObsidianYesterday<CR>',         desc = 'Open [p]revious day' },
    { '<c-o>n',     '<cmd>:ObsidianTomorrow<CR>',          desc = 'Open [n]ext day' },
    { '<c-o><c-t>', '<cmd>:ObsidianTemplate<CR>',          desc = 'Use [t]emplate' },
    { '<c-o>s',     '<cmd>:ObsidianSearch<CR>',            desc = '[s]earch' },
}
local neorg_leader = "<space><c-n>"

wk {
    { "<space><c-n>",      expr = false,                         group = "[<C-N>]eorg",                   nowait = false, remap = false },
    { neorg_leader .. 'n', '<cmd>:Neorg workspace org_mode<cr>', desc = '[<C-n>]eorg [n] activate' },
    { neorg_leader .. 't', '<cmd>:Neorg toc qflist<cr>',         desc = '[<C-n>]eorg [t]able of contents' },
}

local golang_leader = "<space><c-g>"
wk {
    { "<space><c-g>",      expr = false,                         group = "[<C-G>]oPkg",                   nowait = false, remap = false },
    { golang_leader..'p', '<cmd>:GoPkgOutline<cr>', desc = '[<C-n>]eorg [n] activate' },
}

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
local state = {
    floating = {
        buf = -1,
        win = -1,
    }
}

local function create_floating_window(opts)
    opts = opts or {}
    local width = opts.width or math.floor(vim.o.columns * 0.8)
    local height = opts.height or math.floor(vim.o.lines * 0.8)

    -- Calculate the position to center the window
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    -- Create a buffer
    local buf = nil
    if vim.api.nvim_buf_is_valid(opts.buf) then
        buf = opts.buf
    else
        buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
    end

    -- Define window configuration
    local win_config = {
        relative = "editor",
        width = width,
        height = height,
        col = col,
        row = row,
        style = "minimal", -- No borders or extra UI elements
        border = "rounded",
    }

    -- Create the floating window
    local win = vim.api.nvim_open_win(buf, true, win_config)

    return { buf = buf, win = win }
end

local toggle_terminal = function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = create_floating_window { buf = state.floating.buf }
        if vim.bo[state.floating.buf].buftype ~= "terminal" then
            vim.cmd.terminal()
        end
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
end

-- Example usage:
-- Create a floating window with default dimensions
vim.api.nvim_create_user_command("Floaterminal", toggle_terminal, {})
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
vim.keymap.set("n", "<M-t>", toggle_terminal)
