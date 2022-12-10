require('bufferline').setup {
    
    -- Enable/disable animations
    animation = true,
    auto_hide = true,
    tab_size = 18,
    -- Enable/disable close button
    closable = true,

    -- Enables/disable clickable tabs
    -- - left-click: go to buffer
    -- - middle-click: delete buffer
    clickable = true,

    diagnostics = {
        { enabled = true, icon = 'ϗ' }, -- Error
        { enabled = true, icon = 'ξ' }, -- Warning
        { enabled = true, icon = 'Φ' }, -- Info
        { enabled = true, icon = 'π' }, -- Hint
    },

    -- configure icons on the bufferline.
    --
    -- Left side
    icon_separator_active = ' ',
    icon_separator_inactive = ' ',
    icon_close_tab = '﯇',
    icon_close_tab_modified = '',
    icon_pinned = '',

    -- Padding and Size
    maximum_padding = 4,
    minimum_padding = 1,
    maximum_length = 24,


}
