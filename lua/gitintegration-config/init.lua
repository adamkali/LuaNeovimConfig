-- make a function to do a git add -A and git commit -am "message"
-- then message is the first argument

function gitcommit(message)
    if message == nil then
        message = "commit"
    end
    vim.cmd("silent! write")
    vim.cmd("silent! !git add -A")
    vim.cmd("silent! !git commit -am '" .. message .. "'")
end

-- make a function to do a git push
function gitpush()
    vim.cmd("silent! !git push")
end

-- make a function to do a git pull
function gitpull()
    vim.cmd("silent! !git pull")
end

-- makee a function to change the branch
-- then branch is the first argument
-- if the branch is nil, then it will checkout to master
-- if the branch is not nil, then it will checkout to the branch
-- if the branch is not exist, then it will create a new branch
-- and checkout to the new branch
function gitbranch(branch)
    if branch == nil then
        branch = "master"
    end
    vim.cmd("silent! !git checkout " .. branch)
end

-- make a function to do a git merge
-- then branch is the first argument
-- if the branch is nil, then it will merge to master
-- if the branch is not nil, then it will merge to the branch
-- if the branch is not exist, then it will create a new branch
-- and merge to the new branch
-- then it will delete the new branch
-- and checkout to the old branch
function gitmerge(branch)
    if branch == nil then
        branch = "master"
    end
    local oldbranch = vim.fn.system("git rev-parse --abbrev-ref HEAD")
    vim.cmd("silent! !git checkout -b " .. branch)
    vim.cmd("silent! !git merge " .. oldbranch)
    vim.cmd("silent! !git branch -d " .. branch)
    vim.cmd("silent! !git checkout " .. oldbranch)
end

-- make neovim mappings for the functions
-- the mappings are:
-- <leader>gc to gitcommit
-- <leader>gp to gitpush
-- <leader>gl to gitpull
-- <leader>gb to gitbranch
-- <leader>gm to gitmerge
-- <leader>gcm to gitcommit and gitpush
vim.api.nvim_set_keymap("n", "<leader>gc", ":lua gitcommit()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>gp", ":lua gitpush()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>gl", ":lua gitpull()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>gb", ":lua gitbranch()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>gm", ":lua gitmerge()<CR>", {noremap = true, silent = true})
vim.api.nvim_set_keymap("n", "<leader>gcm", ":lua gitcommit()<CR>:lua gitpush()<CR>", {noremap = true, silent = true})

-- export the functions to be used in other lua files
-- so that we can use the functions in other lua files
-- by using require("gitintegration-config")
-- and then we can use the functions by using require("gitintegration-config").functionname()
return {
    gitcommit = gitcommit,
    gitpush = gitpush,
    gitpull = gitpull,
    gitbranch = gitbranch,
    gitmerge = gitmerge
}

