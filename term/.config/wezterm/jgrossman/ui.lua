local function apply_config(config)
    local wez = require("wezterm")
    config.color_scheme = "deepwhite"

    config.font = wez.font("JetBrains Mono NL")
    config.font_size = 15.0
    config.enable_tab_bar = false
end

local M = {
    apply_config = apply_config,
    -- colors = colors,
}

return M
