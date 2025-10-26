local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "Dracula (Official)"
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.window_decorations = "RESIZE"
config.font = wezterm.font("Fira Code")
config.font_size = 12.0

config.window_background_opacity = 0.85
config.text_background_opacity = 0.9

config.keys = {
	-- Switch between panes using Alt + arrow keys
	{
		key = "LeftArrow",
		mods = "ALT",
		action = wezterm.action({ ActivatePaneDirection = "Left" }),
	},
	{
		key = "RightArrow",
		mods = "ALT",
		action = wezterm.action({ ActivatePaneDirection = "Right" }),
	},
	{
		key = "UpArrow",
		mods = "ALT",
		action = wezterm.action({ ActivatePaneDirection = "Up" }),
	},
	{
		key = "DownArrow",
		mods = "ALT",
		action = wezterm.action({ ActivatePaneDirection = "Down" }),
	},
	-- Cycle through panes with Alt + Tab
	{
		key = "Tab",
		mods = "ALT",
		action = wezterm.action({ ActivatePaneDirection = "Next" }),
	},
	{
		key = "Tab",
		mods = "ALT|SHIFT",
		action = wezterm.action({ ActivatePaneDirection = "Prev" }),
	},
}

return config
