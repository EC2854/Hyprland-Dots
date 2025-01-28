return {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    opts = {},
    config = function ()
        require('render-markdown').setup({
            heading = {
                enabled = true,
                sign = true,
                position = 'inline',
                icons = { '', '󰝵','','','',''},
                signs = { '󰫎 ' },
                width = 'full',
                left_margin = 0,
                left_pad = 0,
                right_pad = 0,
                min_width = 0,
                border = false,
                border_virtual = false,
                border_prefix = false,
                above = '▄',
                below = '▀',
                backgrounds = {},
                foregrounds = {
                    'RenderMarkdownH1',
                    'RenderMarkdownH2',
                    'RenderMarkdownH3',
                    'RenderMarkdownH4',
                    'RenderMarkdownH5',
                    'RenderMarkdownH6',
                },
            },
            bullet = {
                enabled = true,
                icons = {''},
                ordered_icons = {},
                left_pad = 0,
                right_pad = 0,
                highlight = 'RenderMarkdownBullet',
            },
            indent = {
                enabled = true,
                per_level = 2,
                skip_level = 0,
                skip_heading = true,
            },
        })
    end
}
