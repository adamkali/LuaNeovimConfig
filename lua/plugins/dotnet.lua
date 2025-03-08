return {
    {
        dir = '/home/adamkali/git/dotnvim',
        ft = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets' },
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
