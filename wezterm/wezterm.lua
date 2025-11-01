local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Dracula (Official)"
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.font = wezterm.font("Fira Code")
config.font_size = 12.0

config.window_background_opacity = 0.97
-- config.text_background_opacity = 0.9

config.keys = {
	-- Switch between panes using Alt + arrow keys
	{
		key = "h",
		mods = "ALT",
		action = wezterm.action({ ActivatePaneDirection = "Left" }),
	},
	{
		key = "l",
		mods = "ALT",
		action = wezterm.action({ ActivatePaneDirection = "Right" }),
	},
	{
		key = "k",
		mods = "ALT",
		action = wezterm.action({ ActivatePaneDirection = "Up" }),
	},
	{
		key = "j",
		mods = "ALT",
		action = wezterm.action({ ActivatePaneDirection = "Down" }),
	},
}

return config
