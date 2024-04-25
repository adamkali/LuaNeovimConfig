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
    opts = {
        server = {
            on_attach = function(client, bufnr)
                -- register which-key mappings
                local wk = require("which-key")
                --wk.register({
                --    ["c"] = {
                --        name = "Rustacean",
                --        c = {
                --            codeAction(),
                --            "Code Action",
                --        },
                --        C = {
                --            open_cargo(),
                --            "Rust Hover Actions",
                --        },
                --        d = {
                --            debuggable(),
                --            "Rust debuggables",
                --        },
                --        D = {
                --            debuggable_last(),
                --            "Rust last debuggable",
                --        },
                --        t = {
                --            testable(),
                --            "Rust testables",
                --        },
                --        T = {
                --            testable_last(),
                --            "Rust last testable",
                --        },
                --        r = {
                --            runnable(),
                --            "Rust runnables",
                --        },
                --        R = {
                --            runnable_last(),
                --            "Rust last runnable",
                --        },
                --        h = {
                --            hover_actions(),
                --            "Rust Hover Actions",
                --        },
                --    }
                --}, { mode = "n", buffer = bufnr, prefix = "-"  })
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
            dap = {}
        },
    },
    config = function(_, opts)
        vim.g.rustaceanvim = vim.tbl_deep_extend("force", {}, opts or {})
    end,
}
