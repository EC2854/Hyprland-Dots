return {
    'nvim-orgmode/orgmode',
    dependencies = {
        { 'nvim-treesitter/nvim-treesitter', lazy = true },
        "akinsho/org-bullets.nvim",
    },
    event = 'VeryLazy',
    config = function()
        -- Load treesitter grammar for org
        require('orgmode').setup_ts_grammar()

        -- Setup treesitter
        require('nvim-treesitter.configs').setup({
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'org' },
            },
            ensure_installed = { 'org' },
        })

        -- Setup orgmode
        require('orgmode').setup({
            org_startup_indented = true,
            org_adapt_indentation = false,
            org_startup_folded = "showeverything",
        })
        require('org-bullets').setup()
    end,
}
