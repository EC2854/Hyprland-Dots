return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
        focus = true,
        modes = {
            preview_float = {
                mode = "diagnostics",
                win = {
                    type = "float",
                    relative = "editor",
                    border = "rounded",
                    title = "Preview",
                    title_pos = "center",
                    position = { 0, -2 },
                    size = { width = 0.4, height = 0.4 },
                    zindex = 200,
                },
            },
        },
    },
}
