return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "HiPhish/rainbow-delimiters.nvim",
        { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }
    },
    config = function()
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({ -- enable syntax highlighting
            highlight = {
                enable = true,
            },
            indent = { 
                enable = false
            },
            -- enable autotagging (w/ nvim-ts-autotag plugin)
            autotag = {
              enable = true,
            },
            -- ensure these language parsers are installed
            ensure_installed = {
                "bash", "c", "go", "lua", "css", "scss", "python", "markdown"
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
            additional_vim_regex_highlighting = false,
        })
    end,
}
