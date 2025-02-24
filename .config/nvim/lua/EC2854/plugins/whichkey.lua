return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
        notify = true,
        plugins = {
            marks = true,
            registers = true,
            spelling = {
                enabled = true,
                suggestions = 20,
            },
            presets = {
                operators = false,
                motions = false,
                text_objects = true,
                windows = true,
                nav = true,
                z = true,
                g = true,
            },
        },
        win = {
            border = "rounded",
        },
        show_help = false,
        show_keys = false,
        spec = {
            {
                { "<leader>/", "<cmd>lua require'telescope.builtin'.find_files()<CR>", desc = "Open File", nowait = true, remap = false },
                { "<leader>B", "<cmd>BadApple<CR>", desc = "Bad Apple", nowait = true, remap = false },
                { "<leader>c", "<cmd>Bdelete!<CR>", desc = "Close Buffer", nowait = true, remap = false },
                { "<leader>l", "<cmd>Lazy<CR>", desc = "Lazy", nowait = true, remap = false },
                { "<leader>q", "<cmd>q!<CR>", desc = "Quit", nowait = true, remap = false },
                { "<leader>T", "<cmd>Trouble preview_float<CR>", desc = "Trouble", nowait = true, remap = false },
                { "<leader>g", "<cmd>LazyGit<CR>", desc = "LazyGit", nowait = true, remap = false },
                { "<leader>n", "<cmd>edit .<CR>", desc = "File Manager", nowait = true, remap = false },

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
                { "<leader>tc", "<cmd>Telescope colorscheme <CR>", desc = "Colorscheme", nowait = true, remap = false },
                { "<leader>tg", "<cmd>Gitsigns toggle_deleted <CR>", desc = "Toggle Git Deleted", nowait = true, remap = false },
                { "<leader>tt", "<cmd>Trouble preview_float toggle<CR>", desc = "Toggle Trouble", nowait = true, remap = false },
                { "<leader>th", "<cmd>nohlsearch <CR>", desc = "No Highlight", nowait = true, remap = false },
                { "<leader>tm", "<cmd>TableModeToggle <CR>", desc = "Toggle Table Mode", nowait = true, remap = false },
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
        },
    }
}
