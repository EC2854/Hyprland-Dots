return {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
    },
    config = function ()
        require("barbecue.ui").toggle()
        require("barbecue").setup({
            attach_navic = true,
            create_autocmd = true,
            show_basename = false,
            show_modified = true,
            theme = "auto",
        })
    end
}
