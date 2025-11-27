-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration
local config = wezterm.config_builder()

-- disable wayland support to work on arch
config.enable_wayland = false

-- keyboard stuff
config.enable_kitty_keyboard = true

-- automatically switch theme based on os theme
-- useful for dynamic theme
local appearance_themes = {
	-- Light = "vscode-light",
	-- Dark = "vscode-dark",
	-- Light = "Vs Code Light+ (Gogh)",
	-- Dark = "Vs Code Dark+ (Gogh)",
	Light = "Catppuccin Latte",
	Dark = "Catppuccin Mocha",
}

-- local appearance = wezterm.gui.get_appearance()
-- config.color_scheme = appearance_themes[appearance]

config.color_scheme = appearance_themes.Dark

-- change the window padding
config.window_padding = {
	left = "1cell",
	right = "1cell",
	top = "0.5cell",
	bottom = "0cell",
}

config.keys = {
	{
		key = "p",
		mods = "CTRL | SHIFT",
		action = wezterm.action.DisableDefaultAssignment,
	},
}

config.window_decorations = "RESIZE"
config.font = wezterm.font("JetBrainsMono Nerd Font Mono")
config.send_composed_key_when_left_alt_is_pressed = true
config.hide_tab_bar_if_only_one_tab = true
config.window_close_confirmation = "NeverPrompt"

-- and finally, return the configuration to wezterm
return config
