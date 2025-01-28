return {
    "nvim-lua/plenary.nvim", -- lua functions that many plugins use
    "nvim-tree/nvim-web-devicons",
    "moll/vim-bbye", --Bdelete
    "RRethy/vim-illuminate",
    "dhruvasagar/vim-table-mode",
    "seandewar/bad-apple.nvim",
    {
        "davidmh/mdx.nvim",
        config = true,
        dependencies = {"nvim-treesitter/nvim-treesitter"}
    },
    lazy = true,
}
