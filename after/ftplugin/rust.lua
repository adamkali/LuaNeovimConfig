local wk = require 'which-key'.add
local rust_leader = "<M-l>"


function Rust()
    return {
        rust_leader, expr = false, group = "Rust", nowait = false, remap = false, icon = { icon = " ", hl = "Function" }
    }
end


wk {

    { rust_leader, expr = false, group = "Rust", nowait = false, remap = false, icon = { icon = " ", hl = "Function" } },
    { rust_leader .. "D", '<cmd>RustLsp! debuggables<cr>', desc = "Rust Last Debuggables" },
    { rust_leader .. "d", '<cmd>RustLsp debuggables<cr>', desc = "Rust Debuggables" },
    { rust_leader .. "t", '<cmd>RustLsp testables<cr>', desc = "Rust Testables" },
    { rust_leader .. "T", '<cmd>RustLsp! testables<cr>', desc = "Rust Last Testables" },
    { rust_leader .. "a", "<cmd>RustLsp codeAction<cr>", desc = "Rust Code Action" },
    { rust_leader .. "K", "<cmd>RustLsp hover actions<cr>", desc = "Rust Hover Actions" },
    { rust_leader .. "k", '<cmd>RustLsp renderDiagnostic cycle<cr>', desc = "Rust Cycle Diagnostic" },
    { rust_leader .. "<M-d>", '<cmd>RustLsp openDocs<cr>', desc = "Rust Open Docs" },
    { rust_leader .. "<M-l>", '<cmd>RustLsp joinLines<cr>', desc = "Rust Open Docs" },
}
