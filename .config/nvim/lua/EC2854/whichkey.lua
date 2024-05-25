local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local setup = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = false, -- adds help for motions
            text_objects = false, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
        layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "center", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    ["/"] = { "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = true }))<CR>", "Open File" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },
    ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
    ["B"] = { "<cmd>BadApple<CR>", "Bad Apple" },
    f = {
        name = "Find",
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    },
    h = {
        name = "Help",
        h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
        M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    },
    t = {
        name = "Toggle/Change",
        b = { "<cmd>lua require('barbecue.ui').toggle() <CR>", "Toggle Barbecue" },
        c = { "<cmd>Telescope colorscheme <CR>", "Colorscheme" },
        h = { "<cmd>nohlsearch <CR>", "No Highlight" },
        M = { "<cmd>lua MiniMap.toggle() <CR>", "Toggle MiniMap" },
        m = { "<cmd>TableModeToggle <CR>", "Toggle Table Mode" },
        n = { "<cmd>NvimTreeToggle <CR>", "Toggle NvimTree" },
        t = { "<cmd>TroubleToggle <CR>", "Toggle Trouble" },
        v = { "<cmd>ToggleTerm <CR>", "Toggle Terminal" },
    },
    b = {
        name = "Buffers",
        i = { "<cmd> Telescope buffers <CR>", "ibuffer"},
        k = { ":Bdelete <CR>", "Kill This Buffer" },
        n = { ":bnext<CR>", "Next Buffer" },
        p = { ":bprevious<CR>", "Previous Buffer" },
        s = { ":w! <CR>", "Save This Buffer" },
    },
    w = {
        name = "Windows",
        w = { "<C-w>w","Next Window" },
        c = { ":q! <CR>","Close Window" },
        v = { ":vsplit <CR>","Vertical Script" },
        s = { ":split <CR>","Horizontal Script" },

        h = { "<C-w>h","Window Left" },
        j = { "<C-w>j","Window Down" },
        k = { "<C-w>k","Window Up" },
        l = { "<C-w>l","Window Right" },

        H = { ":wincmd H<CR>","Buffer Move Left" },
        J = { ":wincmd J<CR>","Buffer Move Down" },
        K = { ":wincmd K<CR>","Buffer Move Up" },
        L = { ":wincmd L<CR>","Buffer Move Right" },
    },
}

local vopts = {
    mode = "v", -- VISUAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}
local vmappings = {
    s = {
        name = "Sort",
        s = { ":!sort<CR>","Sort" },
        r = { ":!sort -r<CR>","Reverse Sort" },
        n = { ":!sort -n<CR>","Numeric Sort" },
    },
    ["S"] = { ":Silicon<CR>", "Screenshot"},
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
