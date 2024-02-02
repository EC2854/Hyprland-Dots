return {
    'echasnovski/mini.map',
    version = '*',
    config = function ()
        require('mini.map').setup({
            symbols = {
                encode = nil,
                scroll_line = '█', 
                scroll_view = '┃',
            },

            -- Window options
            window = {
                -- Side to stick ('left' or 'right')
                side = 'right',

                -- Whether to show count of multiple integration highlights
                show_integration_count = true,

                -- Total width
                width = 15,
                winblend = 0,

                zindex = 10,
            },
        })
    end
}
