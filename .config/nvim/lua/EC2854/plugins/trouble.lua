return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        position = "bottom",
        height = 10,
        icons = true,
        group = true,
        padding = true,
        cycle_results = true,
        multiline = true,
        indent_lines = true,
        win_config = { border = "single" },
        auto_open = false,
        auto_close = true,
        auto_preview = true,
        auto_fold = false,
    },
}
