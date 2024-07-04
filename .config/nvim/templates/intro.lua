-- acc
-- .config/nvim/templates/intro.lua

return {
    "OXY2DEV/intro.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function ()
        require("intro").setup({
            merge = false,

            showStatusline = false,
            shadaValidate = false,

            anchors = {
                position = "bottom",
                corner = "▒",
            },
            pathModifiers = {},

            components = {
                {
                    type = "banner",
                    lines = {
                           "⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⣿⡿⠻⣟⣻⣻⠿⣿⣿⣿⣿⣿⣿⣿⣿",
                           "⣿⣿⣿⣿⣿⣿⣿⢿⣿⣾⣿⣿⣿⣷⣜⢉⣟⣾⡷⣽⡻⣿⣿⣿⣿⣿",
                           "⣿⣿⣿⣿⣿⡿⣡⣾⣿⣿⣿⣿⡿⢿⣿⣷⡩⡽⣛⢷⣿⡪⡻⣿⣿⣿",
                           "⣿⣿⣿⣿⡟⡾⡋⣼⣿⡿⠛⣩⣾⣿⡿⣫⣶⣿⡾⣿⣮⣿⡦⡙⣿⣿",
                           "⣿⣿⣿⣿⢁⠞⣼⡏⡷⣡⡬⡿⣹⡿⣹⣿⢹⣧⢿⢨⡹⢨⡺⢷⡹⣿",
                           "⣿⣿⣿⡟⢪⣸⣿⠸⣉⡟⠜⡵⡟⣼⣿⡇⣿⣿⣿⢸⡍⣔⢸⣸⢷⢹",
                           "⣿⣿⣿⣷⣎⠟⢸⣸⣭⠁⡞⣁⡇⣿⡿⣹⣿⣿⡻⠀⡇⣿⠎⢼⠺⢸",
                           "⣿⣿⣿⣿⡛⠸⡇⢹⡏⠀⠈⠭⠘⡘⢣⠟⢡⠃⠑⠀⢸⠏⠚⠘⡆⣸",
                           "⣿⣿⣿⣿⣷⡀⠩⡸⠁⢲⣤⣼⣷⠃⣀⡄⣠⣀⣸⠆⠀⠀⡄⣸⣷⣿",
                           "⣿⣿⣿⣿⣿⣿⡦⠀⠨⡂⠨⣛⣧⣾⣯⢾⣿⣛⠁⠀⠀⠀⣿⣿⣿⣿",
                           "⣿⣿⣿⣿⣿⡿⣡⣶⣿⣷⣶⡌⣙⣛⣓⣾⡭⠁⠀⠀⢠⢰⣿⣿⣿⣿",
                           "⣿⣿⣿⡿⢏⣾⣿⣿⣿⣿⣿⣷⠘⠿⣻⣥⡀⣀⣴⣧⣿⣿⣿⣿⣿⣿",
                           "⣿⣟⣽⠊⣾⠟⠀⢀⢹⣿⣿⣿⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                           "⡿⠾⠇⠀⣿⡐⣨⣧⣾⣿⣿⡇⠈⢻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                           "⡗⡟⠀⠀⣿⣿⣾⣿⣿⣿⠉⢰⡄⠘⢷⣮⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿",
                    },
                    colors = {
                        "col1",
                    }
                },
                {
                    type = "keymaps",
                    style = "silent",
                    keymaps = {
                        {
                            keyCombination = "f",
                            keyAction = ":Telescope find_files <CR>",
                        },
                        {
                            keyCombination = "e",
                            keyAction = ":ene <BAR> startinsert <CR>",
                        },
                        {
                            keyCombination = "r",
                            keyAction = ":Telescope oldfiles <CR>",
                        },
                        {
                            keyCombination = "q",
                            keyAction = ":qa <CR>",
                        }
                    }
                }
            },
            globalHighlights = {
                red  = { fg = "#f38ba8" },
                mauve  = { fg = "#cba6f7" },
                peach  = { fg = "#fab387" },
                yellow  = { fg = "#f9e2af" },
                pink  = { fg = "#f5c2e7" },
                green  = { fg = "#a6e3a1" },
                sapphire  = { fg = "#74c7ec" },

            },

            animations = {
                delay = 50,
                updateDelay = 20,
                highlightBased = {
                    {
                        groupName = "red",
                        values = {
                            { fg = "#1e1e2e" }, { fg = "#530a38" }, { fg = "#630a38" }, { fg = "#6b0a38" }, { fg = "#730a38" }, { fg = "#7b1a48" }, { fg = "#831a48" }, { fg = "#8b1a48" }, { fg = "#932a58" }, { fg = "#9b2a58" }, { fg = "#a33a68" }, { fg = "#ab3a68" }, { fg = "#b34a78" }, { fg = "#bb4a78" }, { fg = "#c35a88" }, { fg = "#cb5a88" }, { fg = "#d36a98" }, { fg = "#db6a98" }, { fg = "#e37aa8" }, { fg = "#eb7aa8" }, { fg = "#f38ba8" }
                        },
                    },
                    {
                        groupName = "mauve",
                        values = {
                            { fg = "#1e1e2e" }, { fg = "#2b1667" }, { fg = "#3b1667" }, { fg = "#3f2677" }, { fg = "#4b2677" }, { fg = "#4f3677" }, { fg = "#5b3687" }, { fg = "#5f4687" }, { fg = "#6b4697" }, { fg = "#6f5697" }, { fg = "#7b56a7" }, { fg = "#7f66a7" }, { fg = "#8b66b7" }, { fg = "#8f76b7" }, { fg = "#9b76c7" }, { fg = "#9f86c7" }, { fg = "#ab86d7" }, { fg = "#af96d7" }, { fg = "#bb96e7" }, { fg = "#bfa6e7" }, { fg = "#cba6f7" }
                        },
                    },
                    {
                        groupName = "peach",
                        values = {
                            { fg = "#1e1e2e" }, { fg = "#5a2300" }, { fg = "#6a2300" }, { fg = "#6e3307" }, { fg = "#7a3307" }, { fg = "#7e4317" }, { fg = "#8a4317" }, { fg = "#8e5327" }, { fg = "#9a5327" }, { fg = "#9e6337" }, { fg = "#aa6337" }, { fg = "#ae7347" }, { fg = "#ba7347" }, { fg = "#be8357" }, { fg = "#ca8357" }, { fg = "#ce9367" }, { fg = "#da9367" }, { fg = "#dea377" }, { fg = "#eaa377" }, { fg = "#eea387" }, { fg = "#fab387" }
                    },
                    },
                        {
                        groupName = "yellow",
                        values = {
                            { fg = "#1e1e2e" }, { fg = "#59521f" }, { fg = "#69521f" }, { fg = "#69622f" }, { fg = "#79622f" }, { fg = "#79723f" }, { fg = "#89723f" }, { fg = "#89824f" }, { fg = "#99824f" }, { fg = "#99925f" }, { fg = "#a9925f" }, { fg = "#a9a26f" }, { fg = "#b9a26f" }, { fg = "#b9b27f" }, { fg = "#c9b27f" }, { fg = "#c9c28f" }, { fg = "#d9c28f" }, { fg = "#d9d29f" }, { fg = "#e9d29f" }, { fg = "#e9e2af" }, { fg = "#f9e2af" }
                        },
                    },
                    {
                        groupName = "pink",
                        values = {
                            { fg = "#1e1e2e" }, { fg = "#652247" }, { fg = "#752247" }, { fg = "#753257" }, { fg = "#853257" }, { fg = "#854267" }, { fg = "#954267" }, { fg = "#955277" }, { fg = "#a55277" }, { fg = "#a56287" }, { fg = "#b56287" }, { fg = "#b57297" }, { fg = "#a58297" }, { fg = "#b582a7" }, { fg = "#b592b7" }, { fg = "#c592b7" }, { fg = "#c5a2c7" }, { fg = "#d5a2c7" }, { fg = "#d5b2d7" }, { fg = "#e5b2d7" }
                        },
                    },
                    {
                        groupName = "green",
                        values = {
                            { fg = "#1e1e2e" }, { fg = "#065311" }, { fg = "#165311" }, { fg = "#1a6321" }, { fg = "#266321" }, { fg = "#2a7321" }, { fg = "#367331" }, { fg = "#3a8341" }, { fg = "#468341" }, { fg = "#4a9341" }, { fg = "#569351" }, { fg = "#5aa361" }, { fg = "#66a361" }, { fg = "#6ab371" }, { fg = "#76b371" }, { fg = "#7ac381" }, { fg = "#86c381" }, { fg = "#8ad391" }, { fg = "#96d391" }, { fg = "#9ae3a1" }, { fg = "#a6e3a1" }
                        },
                    },
                    {
                        groupName = "sapphire",
                        values = {
                            { fg = "#1e1e2e" }, { fg = "#00334c" }, { fg = "#00375c" }, { fg = "#00476c" }, { fg = "#004b7c" }, { fg = "#04577c" }, { fg = "#045b8c" }, { fg = "#14678c" }, { fg = "#146b9c" }, { fg = "#24779c" }, { fg = "#248bac" }, { fg = "#3487ac" }, { fg = "#3497bc" }, { fg = "#4497bc" }, { fg = "#44a7cc" }, { fg = "#54a7cc" }, { fg = "#54b7dc" }, { fg = "#64b7dc" }, { fg = "#64c7ec" }, { fg = "#74c7ec" }
                        },
                    },
                },
                textBased = {}
            },
        });
    end
}
