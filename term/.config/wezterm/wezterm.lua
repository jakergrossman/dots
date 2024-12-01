local wezterm = require("wezterm")
local ui = require("jgrossman.ui")
local mapping = require("jgrossman.mapping")

local config

if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- ui.apply_config(config)
-- mapping.apply_config(config)

local wez = require("wezterm")
config.font = wez.font("JetBrains Mono NL")
config.font_size = 15.0
config.enable_tab_bar = false
config.color_scheme = "gruber-darker"
config.check_for_updates = false

return config
