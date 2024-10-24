return {
    {
        dir = '/home/adamkali/git/dotnvim',
        ft = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets' },
        keys = {
            { '<leader>ds', function() require('dotnvim').bootstrap() end,  desc = 'Bootstrap Class' },
            { '<leader>db', function() require('dotnvim').build(false) end, desc = 'Build Last Project' },
            { '<leader>dw', function() require('dotnvim').watch(true) end,  desc = 'Watch Last Project' },
        },
        config = function()
            require('dotnvim').setup {
                nuget = {
                    sources = {
                        "efilemadeeasy"
                    },
                    authenticators = {
                        {
                            cmd = "aws",
                            args = { "codeartifact", "login", "--tool", "dotnet", "--domain", "efilemadeeasy", "--domain-owner", "378047982135", "--repository", "eFileMadeEasy-Common" }
                        },
                    },
                },
            }
        end
    }
}
