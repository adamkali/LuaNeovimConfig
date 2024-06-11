--local function debuggable()
--    vim.cmd.RustLsp('debuggables')
--end
--
--local function debuggable_last()
--    vim.cmd.RustLsp{'debuggables', bang = true}
--end
--
--local function runnable()
--    vim.cmd.RustLsp('runnables')
--end
--
--local function runnable_last()
--    vim.cmd.RustLsp{'runnables', bang = true}
--end
--
--local function testable()
--    vim.cmd.RustLsp('testables')
--end
--
--local function testable_last()
--    vim.cmd.RustLsp{'testables', bang = true}
--end
-- 
--local function codeAction()
--    vim.cmd.RustLsp('codeAction')
--end
--
--local function hover_actions()
--    vim.cmd.RustLsp { 'hover', 'actions' }
--end
--
--local function open_cargo()
--    vim.cmd.RustLsp('openCargo')
--end

return {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
    keys = {
		{ "lt", "<cmd>RustLsp testables <cr>", desc = "Find Files" },
		{ "lg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
		{ "lc", "<cmd>Telescope commands<cr>", desc = "List Commands" },
		{ "lb", "<cmd>Telescope buffers<cr>", desc = "List Buffers" },
		{ "ld", "<cmd>Telescope diagnostics<cr>", desc = "Lsp Diagnostics" },
		{ "lr", "<cmd>Telescope lsp_refrences<cr>", desc = "Lsp Refrences" },
    },
    opts = {
        server = {
            on_attach = function(client, bufnr)
                -- register which-key mappings
            end,
            settings = {
                -- rust-analyzer language server configuration
                ["rust-analyzer"] = {
                    cargo = {
                        allFeatures = true,
                        loadOutDirsFromCheck = true,
                        runBuildScripts = true,
                    },
                    -- Add clippy lints for Rust.
                    checkOnSave = {
                        allFeatures = true,
                        command = "clippy",
                        extraArgs = { "--no-deps" },
                    },
                    procMacro = {
                        enable = true,
                        ignored = {
                            ["async-trait"] = { "async_trait" },
                            ["napi-derive"] = { "napi" },
                            ["async-recursion"] = { "async_recursion" },
                        },
                    },
                },
            },
        },
    },
    config = function(_, opts)
        vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})
    end,
}
