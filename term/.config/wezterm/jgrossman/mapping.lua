local M = {}

local wezterm = require("wezterm")

function M.map_builder()
    return {
        maps = {},
        ctrl = function(builder, key, action)
            table.insert(builder.maps,
                {
                     mods = "CTRL",
                    key = key,
                    action = action
                }
            )
            return builder
        end,
    }
end

function M.apply_config(config)
    config.disable_default_key_bindings = true
    config.key_tables = {}
    local act = wezterm.action
    local maps = M.map_builder()
        :ctrl('-', act.DecreaseFontSize)
        :ctrl('=', act.IncreaseFontSize)
        :ctrl('0', act.ResetFontSize)
        .maps

    config.keys = maps
end

return M
