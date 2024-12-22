local map = vim.keymap.set
return {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    ft = { "rust" },
    opts = {
        server = {
            on_attach = function(_, bufnr)
                map (
                    "n",
                    "<leader>rd",
                    function() vim.cmd.RustLsp { 'debuggables' } end,
                    {desc = "Rust Debuggables", buffer = bufnr}
                )
                map (
                    "n",
                     "<leader>rD",
                    function() vim.cmd.RustLsp { 'debuggables', bang = true } end,
                    {desc = "Last Debuggables", buffer = bufnr}
                )
                map (
                    "n",
                     "<leader>rt",
                    function() vim.cmd.RustLsp { 'testables'} end,
                    {desc = "Rust Testables", buffer = bufnr}
                )
                map (
                    "n",
                     "<leader>rT",
                    function() vim.cmd.RustLsp { 'testables', bang = true} end,
                    {desc = "Last Testables", buffer = bufnr}
                )
                map (
                    "n",
                     "<F2>",
                    function() vim.cmd.RustLsp { 'codeAction'} end,
                    {desc = "Code Actions", buffer = bufnr}
                )
                map (
                    "n",
                    "<leader>rc", function ()
                        vim.cmd.RustLsp 'openCargo'
                    end,
                    {desc = "Open Cargo.toml", buffer = bufnr}
                )
            end,
            default_settings = {
                -- rust-analyzer language server configuration
                ["rust-analyzer"] = {
                    cargo = {
                        allFeatures = true,
                        loadOutDirsFromCheck = true,
                        buildScripts = {
                            enable = true,
                        },
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
                            ["napi-derive"] = { "napi" },
                            ["async-recursion"] = { "async_recursion" },
                        },
                    },
                },
            },
        },
    },
    config = function(_, opts)
        vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
    end,
}

