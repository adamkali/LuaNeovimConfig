-- File navigation split mappings
-- gsv: go to file under cursor and split vertically
-- gsh: go to file under cursor and split horizontally

vim.keymap.set("n", "gsv", function()
    vim.cmd("vsplit")
    vim.cmd("normal! gf")
end, { desc = "Go to file under cursor and split vertically" })

vim.keymap.set("n", "gsh", function()
    vim.cmd("split")
    vim.cmd("normal! gf")
end, { desc = "Go to file under cursor and split horizontally" })