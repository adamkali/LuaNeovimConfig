  return {
      {
          dir ='/home/adamkali/git/dotnvim',
          ft = { 'cs', 'vb', 'csproj', 'sln', 'slnx', 'props', 'csx', 'targets' },
          opts = {
              debug = {
                  enabled = true
              },
              nuget = {
                  sources = {
                      "efilemadeeasy"
                  },
                  authenticators = {
                      {
                          cmd = "aws",
                          args = { "codeartifact", "login", "--tool", "dotnet", "--domain", "efilemadeeasy", "--domain-owner", "378047982135", "--repository",
  "eFileMadeEasy-Common" }
                      },
                  },
              },
              -- Task system configuration (now available!)
              tasks = {
                  enabled = true,
                  execution_mode = "dependency_aware",
                  dap_integration = {
                      enabled = true,
                      pre_debug_tasks = nil, -- Auto-discover pre-debug tasks
                      block_on_failure = true,
                      timeout_seconds = 300,
                  }
              }
          }
      }
  }
