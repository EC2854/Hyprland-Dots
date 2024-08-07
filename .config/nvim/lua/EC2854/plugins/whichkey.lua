return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")
        wk.add({ {
                { "<leader>/", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = true }))<CR>", desc = "Open File", nowait = true, remap = false },
                { "<leader>B", "<cmd>BadApple<CR>", desc = "Bad Apple", nowait = true, remap = false },
                { "<leader>c", "<cmd>Bdelete!<CR>", desc = "Close Buffer", nowait = true, remap = false },
                { "<leader>q", "<cmd>q!<CR>", desc = "Quit", nowait = true, remap = false },

                { "<leader>f", group = "Find", nowait = true, remap = false },
                { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Open Recent File", nowait = true, remap = false },

                { "<leader>b", group = "Buffers", nowait = true, remap = false },
                { "<leader>bi", "<cmd> Telescope buffers <CR>", desc = "ibuffer", nowait = true, remap = false },
                { "<leader>bk", ":Bdelete <CR>", desc = "Kill This Buffer", nowait = true, remap = false },
                { "<leader>bn", ":bnext<CR>", desc = "Next Buffer", nowait = true, remap = false },
                { "<leader>bp", ":bprevious<CR>", desc = "Previous Buffer", nowait = true, remap = false },
                { "<leader>bs", ":w! <CR>", desc = "Save This Buffer", nowait = true, remap = false },


                { "<leader>h", group = "Help", nowait = true, remap = false },
                { "<leader>hM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages", nowait = true, remap = false },
                { "<leader>hh", "<cmd>Telescope help_tags<cr>", desc = "Find Help", nowait = true, remap = false },

                { "<leader>t", group = "Toggle/Change", nowait = true, remap = false },
                { "<leader>tM", "<cmd>lua MiniMap.toggle() <CR>", desc = "Toggle MiniMap", nowait = true, remap = false },
                { "<leader>tc", "<cmd>Telescope colorscheme <CR>", desc = "Colorscheme", nowait = true, remap = false },
                { "<leader>th", "<cmd>nohlsearch <CR>", desc = "No Highlight", nowait = true, remap = false },
                { "<leader>tm", "<cmd>TableModeToggle <CR>", desc = "Toggle Table Mode", nowait = true, remap = false },
                { "<leader>tn", "<cmd>NvimTreeToggle <CR>", desc = "Toggle NvimTree", nowait = true, remap = false },
                { "<leader>tt", "<cmd>TroubleToggle <CR>", desc = "Toggle Trouble", nowait = true, remap = false },
                { "<leader>tv", "<cmd>ToggleTerm <CR>", desc = "Toggle Terminal", nowait = true, remap = false },

                { "<leader>w", group = "Windows", nowait = true, remap = false },
                { "<leader>wH", ":wincmd H<CR>", desc = "Buffer Move Left", nowait = true, remap = false },
                { "<leader>wJ", ":wincmd J<CR>", desc = "Buffer Move Down", nowait = true, remap = false },
                { "<leader>wK", ":wincmd K<CR>", desc = "Buffer Move Up", nowait = true, remap = false },
                { "<leader>wL", ":wincmd L<CR>", desc = "Buffer Move Right", nowait = true, remap = false },
                { "<leader>wc", ":q! <CR>", desc = "Close Window", nowait = true, remap = false },
                { "<leader>wh", "<C-w>h", desc = "Window Left", nowait = true, remap = false },
                { "<leader>wj", "<C-w>j", desc = "Window Down", nowait = true, remap = false },
                { "<leader>wk", "<C-w>k", desc = "Window Up", nowait = true, remap = false },
                { "<leader>wl", "<C-w>l", desc = "Window Right", nowait = true, remap = false },
                { "<leader>ws", ":split <CR>", desc = "Horizontal Script", nowait = true, remap = false },
                { "<leader>wv", ":vsplit <CR>", desc = "Vertical Script", nowait = true, remap = false },
                { "<leader>ww", "<C-w>w", desc = "Next Window", nowait = true, remap = false },
            },
            {
                {
                    mode = { "v" },
                    { "<leader>s", group = "Sort", nowait = true, remap = false },
                    { "<leader>sn", ":!sort -n<CR>", desc = "Numeric Sort", nowait = true, remap = false },
                    { "<leader>sr", ":!sort -r<CR>", desc = "Reverse Sort", nowait = true, remap = false },
                    { "<leader>ss", ":!sort<CR>", desc = "Sort", nowait = true, remap = false },
                },
            }
        })
        local setup = {
            icons = {
                breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
                separator = "➜", -- symbol used between a key and it's label
                group = "+", -- symbol prepended to a group
            },
            win = {
                title = false,
                border = "rounded",
                padding = { 2, 2, 2, 2 },
                wo = {
                  winblend = 0,
                },
            },
            layout = {
                height = { min = 4, max = 25 }, -- min and max height of the columns
                width = { min = 20, max = 50 }, -- min and max width of the columns
                spacing = 3, -- spacing between columns
                align = "center", -- align columns left, center or right
            },
            show_help = false,
        }
        wk.setup(setup)
    end,
}
