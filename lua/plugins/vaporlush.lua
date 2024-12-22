local style = "vapor"
--local style = "blossom"
--local style = "1996"

return {
    {
        --dir = "~/git/vaporlush",
        "adamkali/vaporlush",
        branch = "v2",
        lazy = false,
        priority = 1000,
        opts = {
            cache = true,
            style = style
        },
    },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end
    }
}
