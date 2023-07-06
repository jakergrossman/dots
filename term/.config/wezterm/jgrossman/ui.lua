local colors = {
    light_theme = {
        metadata = {
            name = "dawnfox",
            author = "EdenEast",
            origin_url = "https://github.com/EdenEast/nightfox.nvim"
        },
        palette = {
            foreground = "#575279",
            background = "#faf4ed",
            cursor_bg = "#575279",
            cursor_border = "#575279",
            cursor_fg = "#faf4ed",
            compose_cursor = '#d7827e',
            selection_bg = "#d0d8d8",
            selection_fg = "#575279",
            scrollbar_thumb = "#a8a3b3",
            split = "#ebe5df",
            visual_bell = "#575279",

            ansi = {
                "#575279", "#b4637a", "#618774", "#ea9d34", "#286983", "#907aa9", "#56949f", "#e5e9f0"
            },
            brights = {
                "#5f5695", "#c26d85", "#629f81", "#eea846", "#2d81a3", "#9a80b9", "#5ca7b4", "#e6ebf3"
            },
            indexed = {
                [16] = "#d685af",
                [17] = "#d7827e"
            }
        }
    },
    dark_theme = {
        metadata = {
            name = "duskfox",
            author = "EdenEast",
            origin_url = "https://github.com/EdenEast/nightfox.nvim",
        },

        palette = {
            foreground = "#e0def4",
            background = "#232136",
            cursor_bg = "#e0def4",
            cursor_border = "#e0def4",
            cursor_fg = "#232136",
            compose_cursor = '#ea9a97',
            selection_bg = "#433c59",
            selection_fg = "#e0def4",
            scrollbar_thumb = "#6e6a86",
            split = "#191726",
            visual_bell = "#e0def4",
            ansi = { "#393552", "#eb6f92", "#a3be8c", "#f6c177", "#569fba", "#c4a7e7", "#9ccfd8", "#e0def4" },
            brights = { "#47407d", "#f083a2", "#b1d196", "#f9cb8c", "#65b1cd", "#ccb1ed", "#a6dae3", "#e2e0f7" }
        },

        indexed = {
            [16] = "#eb98c3",
            [17] = "#ea9a97"
        }
    }
}

local function apply_config(config)
    local wez = require("wezterm")
    config.colors = colors.light_theme.palette

    config.font = wez.font("JetBrains Mono NL")
    config.font_size = 15.0
    config.enable_tab_bar = false
end

local M = {
    apply_config = apply_config,
    colors = colors,
}

return M
