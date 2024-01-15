return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
        "JoosepAlviste/nvim-ts-context-commentstring",
        "p00f/nvim-ts-rainbow",
        "HiPhish/rainbow-delimiters.nvim",
        { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }
    },
    config = function()
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({ -- enable syntax highlighting
            highlight = {
                enable = true,
            },
            -- enable indentation
            indent = { enable = false },
            -- enable autotagging (w/ nvim-ts-autotag plugin)
            autotag = {
              enable = true,
            },
            -- ensure these language parsers are installed
            ensure_installed = "all",
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        })
    require('ts_context_commentstring').setup {}
    end,
}
