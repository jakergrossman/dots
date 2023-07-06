local wezterm = require("wezterm")
local ui = require("jgrossman.ui")
local mapping = require("jgrossman.mapping")

local config

if wezterm.config_builder then
    config = wezterm.config_builder()
end

ui.apply_config(config)
mapping.apply_config(config)

return config
