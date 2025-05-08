-- Empty Table

local Customs = {
    Neorg = {}, -- use tables for each of your 'custom modules'
}

-- Add a new function to the neorg table

Customs.Neorg.export_configured = function ()
    local parser = require("nvim-treesitter.parsers").get_parser(nil, "norg")
    local query = require("nvim-treesitter.query")

    Snacks.debug(parser)
end

-- Return Populated Table 

return Customs